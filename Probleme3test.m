%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Probleme 3
% -------------------------------------------------------------------------
% Description : 
% fichier test MATLAB associé au probleme 3
%
%
%
% Auteur : G10E
% -------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Fe=20e4; %au delà des fréquences audible 
bits =16;

[a,b,c]=probleme3 (Fe , bits);
print("la musique echantillioné a "+Fe+" sur "+bits+" bits a pour débit "+a+" bits par seconde " + ...
    "et une taille de "+b+" bits pour une heure d'enregistrement et peut renter sur  un CD audio si" + ...
    "la valeur suivante est TRUE"+c )
