%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fichier test de Autocorrelation
% -------------------------------------------------------------------------
% Description : 
% ce fichier sert pour tester et afficher les résultats du programme
% Autocorrelation (NE FONCTIONNE PAS SANS AVOIR OUVERT Autocorelation.m)
%
%
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

f0  = 700;             %  fréquence des signaux  (Hz)
D   = 10/f0;             % durée ( 10 périodes)

% ---- Signal generation

t = 0:Te:D;
N = length(t);          

x = cos(2*pi*f0*t);   %cosinus de fréquence 500hz
y = sin(2*pi*f0*t) ;    %sinus de fréquence 500hz
f=t ;   %fonction linéaire
[g,Fe]= audioread("FluteNote01.mp3");
    %u=0:lenght(g)
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
%identification de la période
N=length(Cyy);
b=0;
for i = 2:N ;
    if Cyy(i)>= Cyy(i-1) && Cyy(i) >= Cyy(i+1);
        "la période est de "+i*Te+"s"
        b=1;
        break
    
    end
end
if b==0;
    "le signal n'a pas de période distincte via autocorrelation"
end
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
%identification de la période
N=length(Cxx);
b=0;
for i = 2:N ;
    if Cxx(i)>= Cxx(i-1) && Cxx(i) >= Cxx(i+1);
        "la période est de "+i*Te+"s"
        b=1;
        break
    end
end
if b==0;
    "le signal n'a pas de période distincte via autocorrelation"
end

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
%identification de la période
N=length(Cff);
b=0;
for i = 2:N ;
    if Cff(i)>= Cff(i-1) && Cff(i) >= Cff(i+1);
        "la période est de "+i*Te+"s"
        b=1;
        break
    end
end
if b==0;
    "le signal n'a pas de période distincte via autocorrelation"
end

figure('Name','Autocorrelation')%affichage du signal audio
subplot(2,1,1);
plot(g);
grid on;
title 'Signal g - time domain'
xlabel 's'
ylabel 'V'
[Cgg,tg] = AutoCorelation(g',Fe);
subplot(2,1,2);
%plot(tg,Cgg);%affichage de sa correlation
grid on
title 'Autocorrelation of signal g '
xlabel 's'
ylabel 'W'
%identification de la période
N=length(Cgg);
b=0;
for i = 2:N ;
    if Cgg(i)>= Cgg(i-1) && Cgg(i) >= Cgg(i+1);
        "la période est de "+i*Te+"s"
        b=1;
        break
 
    end
end
if b==0;
    "le signal n'a pas de période distincte via autocorrelation"
end

