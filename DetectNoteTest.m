function [SegmentNoteNames] = DetectNoteTest()
    % Paramètres de la gamme
    notes = {'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B'};
    baseFreq = 440; % Fréquence de La4
    baseNoteIndex = 10; % La4 est la 10e note de l'octave 4

    % Générer les fréquences et les noms des notes
    frequenciesNotes = []; % Tableau pour stocker les fréquences
    noteNames = {}; % Cellule pour les noms des notes

    for octave = 1:6
        for noteIndex = 1:12
            % Calcul de l'indice de la note par rapport à La4
            n = (octave - 4) * 12 + (noteIndex - baseNoteIndex);
            % Calcul de la fréquence
            freq = baseFreq * 2^(n / 12);
            frequenciesNotes = [frequenciesNotes, freq];
            % Ajouter le nom de la note avec son octave
            noteNames{end+1} = sprintf('%s%d', notes{noteIndex}, octave);
        end
    end

    % Afficher les fréquences et les noms des notes pour vérification
    disp('Fréquences générées et leurs noms :');
    for i = 1:length(frequenciesNotes)
        fprintf('%.2f Hz -> %s\n', frequenciesNotes(i), noteNames{i});
    end

    % Test avec un ensemble de fréquences
    testFrequencies = [3.966607862903230e+03, 3.738835011427510e+03, 1.196541457800270e+04, 2.803865131578950e+03, 3.703915284938000e+03, 3.195382127499100e+03, 6.488924149737980e+03, 4.256596465746790e+03, 1.945601879036990e+04, 4.191870912900510e+03, 4.322088271053360e+03, 6.963626086558000e+03];
    disp('Test des fréquences :');5.516680743243240e+03;
    disp(testFrequencies);

    % Afficher les résultats des tests
    disp('Résultats des tests :');
    for i = 1:length(testFrequencies)
        fprintf('Fréquence : %.2f Hz -> Note : %s\n', testFrequencies(i));
    end
end
