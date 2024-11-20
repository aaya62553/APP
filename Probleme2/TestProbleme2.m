clear 
close all
clc

notes_path = dir("Notes");

csvData = {};

for i = 1:length(notes_path)
    if notes_path(i).isdir
        continue;
    end

    fileName = notes_path(i).name;

    note_path = fullfile("Notes", fileName);
    fileName=strsplit(fileName,'.');
    fileName=fileName(1);
    disp("Processing "+fileName);

    [td, tf,D,P_dbm,f0a,f0f,fh,nh] = Probleme2(note_path);
    f0a=mean(f0a);
    f0f=mean(f0f);
    Note_temp=DetectNote(f0a);
    Note_freq=DetectNote(f0f);
    D=round(D*100)/100;
    P_dbm=round(P_dbm*100);
    f0a=round(f0a*100)/100;
    f0f=round(f0f*100)/100;
    td_str = strjoin(string(td), '; '); 
    tf_str = strjoin(string(tf), '; '); 


    % Ajouter les données au tableau
    csvData = [csvData; {fileName, td_str,tf_str,D,P_dbm,f0a,f0f,fh,nh, Note_temp,Note_freq}];

end

csvTable = cell2table(csvData, 'VariableNames', {'Nom Fichier','Temps debut (s)','Temps Fin (s)', ...
    'Duree Note(s)','Puissance (dbm)', 'F0 temporel (Hz)','F0 frequentiel (Hz)', ...
    'Fh (Hz)','Nombres harmoniques','Note par methode temporel','Note par methode frequentiel'});

% Sauvegarder le fichier CSV
writetable(csvTable, 'resultats_detection_notes.csv');
disp('Fichier CSV généré : resultats_detection_notes.csv');


% [td, tf,D,P_dbm,f0a,f0f,fh,nh]=Probleme2('Notes/ViolonNote07.mp3');
