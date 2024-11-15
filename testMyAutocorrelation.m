
clear all
close all
clc

% ---- Signal parameters
Fe  = 10e4;             % Sampling frequency (Hz)
Te = 1/Fe;

f0  = 500;             % Sinus frequency (Hz)
D   = 3/f0;             % Duration (s) : consider 10 periods -- to be completed 
Ax  = 2.7;              % Amplitude for signal x (V)
phi = -pi/3;             % phase for signal y

% ---- Signal generation

t = 0:Te:D;
N = length(t);          % Number of samples

x = Ax*cos(2*pi*f0*t+phi); % To be completed

% ---- Signal display
figure('Name','Autocorrelation')
subplot(2,1,1);
plot(t,x);
grid on;
title 'Signal x - time domain'
xlabel 's'
ylabel 'V'

% ----  Intercorrelation
txmax = 1/f0;
[Cxx,tx] = myAutocorrelation(x,Fe,txmax);
subplot(2,1,2);
plot(tx,Cxx);
grid on
title 'Autocorrelation of signal x'
xlabel 's'
ylabel 'W'




