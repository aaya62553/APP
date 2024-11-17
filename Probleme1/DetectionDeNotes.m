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


function [startIdxSec,endIdxSec,frequencies,SegmentNoteNames]=DetectionDeNotes(audio_path,print_graphs)

% Etape 1 : Chargement du fichier audio
[audioSignal, Fe] = audioread(audio_path);

t = (0:length(audioSignal)-1) / Fe;  % Créer un vecteur de temps
if print_graphs==true
    figure;
    plot(t, audioSignal)
    xlabel('Temps (secondes)');
    ylabel('Amplitude');
    title("Signal audio");
end


% Étape 2 : Détection des segments actifs
winSize = round(0.02 * Fe); % Fenêtre de 20 ms
hopSize = round(0.01 * Fe); % Recouvrement de 50 %
pSeuil = 0.0005; % Seuil d'énergie (ajuster selon les données)

segments = []; % Pour stocker les segments actifs
startIdx = [];
endIdx = [];
isActive = false;

%Segment du signal de 10ms
for i = 1:hopSize:(length(audioSignal) - winSize)
    segment = audioSignal(i:i + winSize - 1);
    p = sum(segment .^ 2) / winSize;

    if p > pSeuil
        if ~isActive
            startIdx = [startIdx, i]; % Début d'un segment actif
            isActive = true;
        end
    else
        if isActive
            endIdx = [endIdx, i + winSize - 1]; % Fin d'un segment actif
            isActive = false;
        end
    end
end
% Si le dernier segment actif n'a pas de fin
if isActive
    endIdx = [endIdx, length(audioSignal)];
end

startIdxSec=startIdx'/Fe;
endIdxSec=endIdx'/Fe;

% Étape 3 : Extraction des fréquences fondamentales
frequencies = [];
if print_graphs==true
    figure;
end
for i = 1:length(startIdx)
    segment = audioSignal(startIdx(i):endIdx(i));
    [autocorrValues, lags] = AutoCorelation(segment);

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

    period = lags(secondPeakIdx+1);
    f0_detected = 1 / period; % Fréquence fondamentale (Hz)

    if f0_detected > 100 && f0_detected < 2000
        frequencies = [frequencies, f0_detected]; % Stocker la fréquence détectée
    end

    ncols=2;
    if isscalar(startIdx)
        ncols=1;
    end

    if print_graphs==true
        subplot(ceil(length(startIdx) / 2), ncols, i);
        plot(lags, autocorrValues);  % Tracer l'autocorrélation
        hold on;
        plot(lags(secondPeakIdx + 1), autocorrValues(secondPeakIdx + 1), 'ro');  % Marquer le pic détecté
        xlabel('Décalage (secondes)');
        ylabel('Autocorrélation');
        title(['Autocorrélation - Segment ', num2str(i)]);
    end

end



% Paramètres de la gamme
notes = {'Do', 'Do#', 'Ré', 'Ré#', 'Mi', 'Fa', 'Fa#', 'Sol', 'Sol#', 'La', 'La#', 'Si'};
baseFreq = 440; % Fréquence du La4
baseNoteIndex = 10; % La4 est la 10e note de l'octave 4


frequenciesNotes = []; % Tableau vide pour stocker les fréquences
noteNames = {}; % Cellule pour les noms des notes

% Générer les fréquences et les noms des notes
for octave = 1:6
    for noteIndex = 1:12
        % Calcul de l'indice de la note par rapport au La4
        n = (octave - 3) * 12 + (noteIndex - baseNoteIndex);

        % Calcul de la fréquence
        freq = baseFreq * 2^(n / 12);
        frequenciesNotes = [frequenciesNotes; freq];

        % Ajouter le nom de la note avec son octave
        noteNames{end+1} = sprintf('%s%d', notes{noteIndex}, octave);
    end
end

% Attribution des noms de notes pour les segments détectés
SegmentNoteNames = strings(0, 1);
for f = frequencies
    if isnan(f)  % Gérer les valeurs manquantes
        SegmentNoteNames = [SegmentNoteNames; "NaN"];
    else
        % Trouver la note dont la fréquence est la plus proche
        [~, idx] = min(abs(frequenciesNotes - f));
        SegmentNoteNames = [SegmentNoteNames; string(noteNames{idx})];
    end
end

disp("-------------------")
disp("Nom du signal audio :");
disp(audio_path);

% Affichage des résultats
disp('Instants de début et de fin des segments actifs :');
disp([startIdxSec, endIdxSec]);


disp('Fréquences fondamentales (Hz) :');
disp(frequencies');

disp('Notes détectées :');
disp(SegmentNoteNames);

end
