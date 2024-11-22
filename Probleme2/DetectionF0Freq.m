%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fonction : DetectionF0Freq
% -------------------------------------------------------------------------
% Description : 
% Cette fonction détecte la fréquence fondamentale (F0) d'un signal audio 
% en utilisant son spectre de Fourier. Elle peut également afficher des 
% graphiques du signal temporel et de son spectre si demandé.
%
% Entrées :
%   - x : [vecteur] Signal audio à analyser.
%   - Fe : [scalaire] Fréquence d'échantillonnage du signal (en Hz).
%   - print_graphs : [booléen] Indique si les graphiques doivent être affichés.
%
% Sorties :
%   - f0 : [scalaire] Fréquence fondamentale détectée (en Hz).
%
% Auteur : G10E
% -------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [f0]=DetectionF0Freq(x,Fe,print_graphs)

N=length(x);

audio_fft=fft(x,N);
audio_fft=abs(audio_fft);
f=(0:N-1) * (Fe / N);

for i=2:length(audio_fft)-1
    if audio_fft(i)>audio_fft(i-1) && audio_fft(i)>audio_fft(i+1) && audio_fft(i)>max(audio_fft)/4
        kmax=i;
        break
    end 
end 
%[~,kmax]=max(audio_fft);
if f(kmax)<2*Fe
    f0=f(kmax);
end 
if print_graphs==true
    figure;
    plot(f,audio_fft);
    xlabel('Fréquences (Hz)');
    ylabel('Amplitude');
    title("Signal audio");
end

end
