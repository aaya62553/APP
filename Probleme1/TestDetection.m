%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Script de Détection de Notes Musicales et Exportation des Résultats en CSV
% -------------------------------------------------------------------------
% Description : 
% Ce script permet de traiter tous les fichiers audio (fichiers .mp3) présents dans
% le dossier "Notes" et d'en détecter les fréquences fondamentales ainsi que
% les noms des notes. Les résultats sont ensuite exportés dans un fichier CSV.
% 
% Fonctionnement :
% 1. Chargement des fichiers audio à partir du dossier "Notes".
% 2. Utilisation de la fonction `DetectionDeNotes` pour analyser chaque fichier audio.
% 3. Extraction des fréquences fondamentales et des noms des notes détectées.
% 4. Création d'un tableau contenant le nom du fichier, les fréquences détectées, 
%    et les noms des notes associées.
% 5. Exportation des résultats dans un fichier CSV intitulé `resultats_detection_notes.csv`.
%
% Auteur : G10E
% -------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



clear;
clc;
close all;

notes_path = dir("Notes");

csvData = {};

for i = 1:length(notes_path)
    if notes_path(i).isdir
        continue;
    end

    fileName = notes_path(i).name;
    note_path = fullfile("Notes", fileName);

    % Appeler la fonction de détection

    [~, ~, frequencies, SegmentNoteNames] = DetectionDeNotes(note_path, false);

    % Convertir les données pour l'exportation
    frequenciesStr = strjoin(string(frequencies), ', '); % Fréquences en une seule chaîne
    noteNamesStr = strjoin(SegmentNoteNames, ', '); % Noms des notes en une seule chaîne

    % Ajouter les données au tableau
    csvData = [csvData; {fileName, frequenciesStr, noteNamesStr}];

end

csvTable = cell2table(csvData, 'VariableNames', {'NomFichier', 'FrequencesFundamentales', 'NomsNotes'});

% Sauvegarder le fichier CSV
writetable(csvTable, 'resultats_detection_notes.csv');
disp('Fichier CSV généré : resultats_detection_notes.csv');

%DetectionDeNotes('Notes\ViolonNote02.mp3',true);