
clc
clear 
close all


% Etape 1 : Chargement du fichier audio
[audioSignal, Fe] = audioread('Notes/PianoNote06.mp3');

t = (0:length(audioSignal)-1) / Fe;  % Créer un vecteur de temps
figure;
plot(t, audioSignal)
xlabel('Temps (secondes)');
ylabel('Amplitude');
title("Signal audio");



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


% Étape 3 : Extraction des fréquences fondamentales
frequencies = [];
figure;

for i = 1:length(startIdx)
    segment = audioSignal(startIdx(i):endIdx(i));
    [autocorrValues, lags] = AutoCorelation(segment);

    autocorrValues = autocorrValues(lags >= 0); % Ne garder que la partie positive
    lags = lags(lags >= 0);

    [~, idx] = max(autocorrValues(3:end)); % Trouver le maximum après le premier indice (lag = 0)
    period = lags(idx+1);
    f0_detected = 1 / period; % Fréquence fondamentale (Hz)

    if f0_detected > 100 && f0_detected < 2000
        frequencies = [frequencies, f0_detected]; % Stocker la fréquence détectée
    end
    
    ncols=2;
    if isscalar(startIdx)
        ncols=1;
    end 


    subplot(ceil(length(startIdx) / 2), ncols, i);
    plot(lags, autocorrValues);  % Tracer l'autocorrélation
    hold on;
    plot(lags(idx + 1), autocorrValues(idx + 1), 'ro');  % Marquer le pic détecté
    xlabel('Décalage (secondes)');
    ylabel('Autocorrélation');
    title(['Autocorrélation - Segment ', num2str(i)]);

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
SegmentNoteNames = [];
for f = frequencies
    if isnan(f)  % Gérer les valeurs manquantes
        SegmentNoteNames = [SegmentNoteNames; "NaN"];
    else
        % Trouver la note dont la fréquence est la plus proche
        [~, idx] = min(abs(frequenciesNotes - f));
        SegmentNoteNames = [SegmentNoteNames; noteNames{idx}];
    end
end

% Affichage des résultats
disp('Instants de début et de fin des segments actifs :');
disp([startIdx' / Fe, endIdx' / Fe]);


disp('Fréquences fondamentales (Hz) :');
disp(frequencies');

disp('Notes détectées :');
disp(SegmentNoteNames);
