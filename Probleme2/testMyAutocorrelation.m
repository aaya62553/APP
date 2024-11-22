%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fichier test de Autocorrelation
% -------------------------------------------------------------------------
% Description : 
% ce fichier sert pour tester et afficher les résultats du programme
% Autocorrelation (NE FONCTIONNE PAS SANS AVOIR OUVERT Autocorelation.m)
%
% Auteur : G10E
% -------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc

% ---- Signal parameters
Fe  = 10e4;             % fréquence d'echantillonage (Hz)
Te = 1/Fe;

f0  = 500;             %  fréquence des signaux  (Hz)
D   = 10/f0;             % durée ( 10 périodes)

% ---- Signal generation

t = 0:Te:D;
N = length(t);          

x = cos(2*pi*f0*t);   %cosinus de fréquence 500hz
y = sin(2*pi*f0*t) ;    %sinus de fréquence 500hz
f=t ;   %fonction linéaire

% ---- affichage de tests (2 par fenêtre le signal et son autocorrelation)
figure('Name','Autocorrelation') %affichage du sinus
subplot(2,1,1);
plot(t,y);
grid on;
title 'Signal y - time domain'
xlabel 's'
ylabel 'V'
[Cyy,ty] = AutoCorelation(y,Fe);
subplot(2,1,2);
plot(ty,Cyy);%affichage de sa correlation 
grid on
title 'Autocorrelation of signal y '
xlabel 's'
ylabel 'W'

figure('Name','Autocorrelation')%affichage du cosinus
subplot(2,1,1);
plot(t,x);
grid on;
title 'Signal x - time domain'
xlabel 's'
ylabel 'V'
[Cxx,tx] = AutoCorelation(x,Fe);
subplot(2,1,2);
plot(tx,Cxx);%affichage de sa correlation
grid on
title 'Autocorrelation of signal x '
xlabel 's'
ylabel 'W'

figure('Name','Autocorrelation')%affichage de la fonction linéaire
subplot(2,1,1);
plot(t,f);
grid on;
title 'Signal f - time domain'
xlabel 's'
ylabel 'V'
[Cff,tf] = AutoCorelation(f,Fe);
subplot(2,1,2);
plot(tf,Cff);%affichage de sa correlation
grid on
title 'Autocorrelation of signal x '
xlabel 's'
ylabel 'W'


