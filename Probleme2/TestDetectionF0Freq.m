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

%graphique test 1

figure('Name','DetectionF0Freq')%affichage du cosinus
subplot(3,1,1);
plot(t,x);
grid on;
title 'test pour f0 = 500 Hz'
xlabel 's'
ylabel 'V'

[f0_detectee] = DetectionF0Freq(x,Fe,true);

disp(['Fréquence fondamentale détectée : ', num2str(f0_detectee), ' Hz']);


%graphique test 2

f1 = 200;



x2 = sin ( 2 * pi * f1 * t);

figure('Name','DetectionF0Freq') %affichage du cosinus
subplot(3,1,2);
plot(t,x2);
grid on;
title 'Signal x - time domain'
xlabel 's'
ylabel 'V'

[f1_detectee] = DetectionF0Freq(x2,Fe,true);

disp(['Fréquence fondamentale détectée : ', num2str(f1_detectee), ' Hz']);



%graphique test 3
f2 = 600;

x3 = sin ( 2 * pi * f2 * t);

figure('Name','DetectionF0Freq') %affichage du cosinus
subplot(3,1,3);
plot(t,x3);
grid on;
title 'Signal x - time domain'
xlabel 's'
ylabel 'V'

[f2_detectee] = DetectionF0Freq(x3,Fe,true);

disp(['Fréquence fondamentale détectée : ', num2str(f2_detectee), ' Hz']);


%graphique test 4
f3 = 1110;

x4 = cos ( 2 * pi * f3 * t);

figure('Name','DetectionF0Freq') %affichage du cosinus
subplot(3,1,3);
plot(t,x3);
grid on;
title 'Signal x - time domain'
xlabel 's'
ylabel 'V'

[f3_detectee] = DetectionF0Freq(x4,Fe,true);

disp(['Fréquence fondamentale détectée : ', num2str(f3_detectee), ' Hz']);




