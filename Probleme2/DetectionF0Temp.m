%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fonction : DetectionF0Temp
% -------------------------------------------------------------------------
% Description : 
% Cette fonction détecte la fréquence fondamentale (F0) d'un signal audio 
% en utilisant l'autocorrélation. Si demandé, elle peut également afficher 
% des graphiques pour illustrer les résultats.
%
% Entrées :
%   - audioSignal : [vecteur] Signal audio pour lequel F0 doit être détectée.
%   - Fe : [scalaire] Fréquence d'échantillonnage du signal (en Hz).
%   - print_graphs : [booléen] Indique si les graphiques doivent être affichés.
%
% Sorties :
%   - frequencies : [vecteur] Liste des fréquences fondamentales détectées (en Hz).
%
% Auteur : G10E
% -------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [frequencies]=DetectionF0Temp(audioSignal,Fe,print_graphs)

% Étape 3 : Extraction des fréquences fondamentales
frequencies = [];
if print_graphs==true
    figure;
end
[autocorrValues, lags] = AutoCorelation(audioSignal,Fe);

autocorrValues = autocorrValues(lags >= 0); % Ne garder que la partie positive
lags = lags(lags >= 0);

%Trouver le 2e pic après lag=0
seuil=0.8*max(autocorrValues);
significantPeaks=autocorrValues>seuil;
count=0;
for j=2:length(significantPeaks)
    if significantPeaks(j)==1 && significantPeaks(j-1)==0
        while (significantPeaks(j+count)==1)
            count=count+1;
        end
        break
    end
end
secondPeakIdx=round(j+count/2);
period = lags(secondPeakIdx);
f0_detected = 1 / period; % Fréquence fondamentale (Hz)

if f0_detected > 100 && f0_detected < 2000
    frequencies = [frequencies, f0_detected]; % Stocker la fréquence détectée

    %
    % ncols=2;
    % if isscalar(startIdx)
    %     ncols=1;
    % end

    % if print_graphs==true
    %     subplot(ceil(length(startIdx) / 2), ncols, i);
    %     plot(lags, autocorrValues);  % Tracer l'autocorrélation
    %     hold on;
    %     plot(lags(secondPeakIdx + 1), autocorrValues(secondPeakIdx + 1), 'ro');  % Marquer le pic détecté
    %     xlabel('Décalage (secondes)');
    %     ylabel('Autocorrélation');
    %     title(['Autocorrélation - Segment ', num2str(i)]);
    % end

end
end
