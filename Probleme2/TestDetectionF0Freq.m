%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fichier test de DetectionF0Freq
% -------------------------------------------------------------------------
% Description : 
% ce fichier sert pour tester et afficher les résultats du programme
% DetectionF0Freq (NE FONCTIONNE PAS SANS AVOIR OUVERT DetectionF0Freq.m)
%
% Auteur : G10E
% -------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;
clc;

%Paramètre du signal :

Fe = 10e4;
Te = 1/Fe;

f0 = 500;
D = 2;

t = 0:Te:D;
N = length(t);

x = cos (2 * pi *f0 * t);

% test 1 pour f0 = 500Hz

[f0_detectee] = DetectionF0Freq(x,Fe,true);

disp ('Test pour un signal de fréquence de 500 Hz : ');
disp(['Fréquence fondamentale détectée : ', num2str(f0_detectee), ' Hz']);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f1 = 200;
x2 = sin ( 2 * pi * f1 * t);

% test 2 pour f1 = 200Hz

[f1_detectee] = DetectionF0Freq(x2,Fe,true);

disp ('Test pour un signal de fréquence de 200 Hz : ');
disp(['Fréquence fondamentale détectée : ', num2str(f1_detectee), ' Hz']);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


f2 = 600;
x3 = sin ( 2 * pi * f2 * t);

% test 3 pour f2 = 600Hz

[f2_detectee] = DetectionF0Freq(x3,Fe,true);

disp ('Test pour un signal de fréquence de 600 Hz : ');
disp(['Fréquence fondamentale détectée : ', num2str(f2_detectee), ' Hz']);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


f3 = 1110;
x4 = cos ( 2 * pi * f3 * t);

% test 4 pour f3 = 1110 Hz

[f3_detectee] = DetectionF0Freq(x4,Fe,true);

disp ('Test pour un signal de fréquence de 1110 Hz : ');
disp(['Fréquence fondamentale détectée : ', num2str(f3_detectee), ' Hz']);




