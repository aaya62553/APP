%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fichier test de DetectNote
% -------------------------------------------------------------------------
% Description : 
% ce fichier sert pour tester et afficher les résultats du programme
% DetectNote (NE FONCTIONNE PAS SANS AVOIR OUVERT DetectNote)
%
% Auteur : G10E
% -------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Définir un vecteur de fréquences à tester
frequencies = [440, 466.16, 493.88, NaN, 261.63]; % La4, La#4, Si4, NaN, Do4

% Appeler la fonction DetectNote
SegmentNoteNames = DetectNote(frequencies);

% Afficher les résultats
disp('Fréquences :');
disp(frequencies);

disp('Noms des notes détectées :');
disp(SegmentNoteNames);
