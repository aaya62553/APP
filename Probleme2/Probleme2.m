%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fonction : Probleme2
% -------------------------------------------------------------------------
% Description : 
% Cette fonction analyse un signal audio pour extraire plusieurs 
% caractéristiques telles que la durée totale des segments actifs, la 
% puissance moyenne en dBm, les fréquences fondamentales détectées, et les 
% paramètres spectraux comme la fréquence haute contenant 99.99% de la 
% puissance et le nombre d'harmoniques dans cette bande.
%
% Entrées :
%   - audio_path : [chaîne] Chemin du fichier audio à analyser.
%
% Sorties :
%   - startIdx : [vecteur] Temps de début des segments actifs (en secondes).
%   - endIdx : [vecteur] Temps de fin des segments actifs (en secondes).
%   - D : [scalaire] Durée totale des segments actifs (en secondes).
%   - P_dbm : [scalaire] Puissance moyenne du signal en dBm.
%   - f0_temp : [vecteur] Fréquences fondamentales détectées par méthode temporelle (en Hz).
%   - f0_freq : [vecteur] Fréquences fondamentales détectées par méthode fréquentielle (en Hz).
%   - fh : [scalaire] Fréquence haute contenant 99.99% de la puissance spectrale (en Hz).
%   - nh : [scalaire] Nombre d'harmoniques dans la bande [0, fh].
%
% Auteur : G10E
% -------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [startIdx,endIdx,D,P_dbm,f0_temp,f0_freq,fh,nh]=Probleme2(audio_path)
[audioSignal,Fe]=audioread(audio_path);
N=length(audioSignal);
[startIdx,endIdx]=SignalUtile(audioSignal,Fe);

D=sum(endIdx-startIdx);

P_dbm=10*log10(mean(audioSignal.^2)/0.001); %puissance du signal total ou juste signal utile ?

%frequences fondamentales
f0_temp=[];
f0_freq=[];
for i=1:length(startIdx)
    startSample = round(startIdx(i) * Fe); % Convertir startIdx en un indice 
    endSample = round(endIdx(i) * Fe); % Convertir endIdx en un indice
    segment = audioSignal(startSample:endSample);    
    f0_temp=[f0_temp,DetectionF0Temp(segment,Fe,false)];
    f0_freq=[f0_freq,DetectionF0Freq(audioSignal,Fe,false)];

end

fft_signal=fft(audioSignal);
psd=abs(fft_signal(1:floor(N/2)+1)).^2;
psd=psd/sum(psd);
f = (0:N/2)*(Fe/N);

%𝑓ℎ, la fréquence haute telle que [0,𝑓ℎ] contient 99.99% de la puissance
cumulative_power=zeros(1,length(psd));
cumulative_power(1)=psd(1);
for i=2:length(psd)
    cumulative_power(i)=cumulative_power(i-1)+psd(i);
end

idx=find(cumulative_power>=0.9999,1);
fh=f(idx);

%nh, le nombre d’harmoniques dans cette bande de fréquences.
seuil=max(psd)/30;
peak_freqs=[];
exclusion_window = 100; % Taille de la fenêtre d'exclusion (en indices)
i=2;
while i < length(psd)-1
    % Vérifier si l'indice courant est un pic local et dépasse le seuil
    if psd(i) > psd(i-1) && psd(i) > psd(i+1) && psd(i) > seuil
        %if abs(f0/f(i) - round(f0/f(i)))<0.01
            peak_freqs(end+1) = f(i); % Ajouter la fréquence correspondante au pic
            i = i + exclusion_window; % Sauter les indices dans la fenêtre d'exclusion
        %end 
            
    else
        i = i + 1; % Passer à l'indice suivant
         
    end
end

peak_freqs=peak_freqs(peak_freqs<=fh);
nh=length(peak_freqs);

% plot(f, psd);
% xline(fh, 'k--'); % Ligne verticale pour fh
% title('Densité spectrale et détection manuelle des harmoniques');
% xlabel('Fréquence (Hz)');
% ylabel('Amplitude (Puissance)');
