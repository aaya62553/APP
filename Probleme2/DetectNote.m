%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fonction : DetectNote
% -------------------------------------------------------------------------
% Description : 
% Cette fonction associe les fréquences détectées à des noms de notes 
% musicales en fonction de leur proximité avec les fréquences standard 
% de la gamme tempérée. Elle retourne les noms des notes pour chaque 
% fréquence détectée.
%
% Entrées :
%   - frequencies : [vecteur] Fréquences détectées (en Hz).
%
% Sorties :
%   - SegmentNoteNames : [vecteur de chaînes] Noms des notes musicales 
%     correspondantes pour les fréquences d'entrée.
%
% Auteur : G10E
% -------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [SegmentNoteNames]=DetectNote(frequencies)
% Paramètres de la gamme
notes = {'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B'};
baseFreq = 440; % Fréquence du La4
baseNoteIndex = 10; % La4 est la 10e note de l'octave 4


frequenciesNotes = []; % Tableau vide pour stocker les fréquences
noteNames = {}; % Cellule pour les noms des notes

% Générer les fréquences et les noms des notes
for octave = 1:6
    for noteIndex = 1:12
        % Calcul de l'indice de la note par rapport au La4
        n = (octave - 4) * 12 + (noteIndex - baseNoteIndex);

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
end 
