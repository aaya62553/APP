%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fonction : DetectionDeNotes
% -------------------------------------------------------------------------
% Description :
%   Cette fonction détecte et identifie les notes jouées dans un fichier audio.
%   Elle segmente le signal en parties actives, calcule les fréquences
%   fondamentales de chaque segment, et associe ces fréquences aux noms
%   des notes musicales correspondantes.
%
% Entrées :
%   - audio_path (string) : Chemin du fichier audio à analyser.
%   - print_graphs (bool) : Indicateur pour afficher les graphiques
%       - true : affiche les graphiques du signal, et
%                des autocorrélations.
%       - false : n'affiche aucun graphique.
%
% Sorties :
%   - startIdxSec (vector) : Vecteur des instants de début des segments actifs (en secondes).
%   - endIdxSec (vector) : Vecteur des instants de fin des segments actifs (en secondes).
%   - frequencies (vector) : Fréquences fondamentales détectées pour chaque segment actif (en Hz).
%   - SegmentNoteNames (vector) : Noms des notes détectées pour chaque segment actif.
%
% Étapes principales :
%   1. Lecture du signal audio.
%   2. Détéction des segmentents actifs à l'aide d'un seuil de puissance.
%   3. Calcul des fréquences fondamentales de chaque segment actif grâce à l'autocorrélation.
%   4. Attribution des noms de notes.
%
% Exemple d'utilisation :
%   [startIdxSec, endIdxSec, frequencies, SegmentNoteNames] = ...
%       DetectionDeNotes('Notes/PianoNote09.mp3', true);
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
