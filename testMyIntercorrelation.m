
clear all
close all
clc

% ---- Signal parameters
Fe  = 10e4;             % Sampling frequency (Hz)
Te = 1/Fe;

f0  = 500;             % Sinus frequency (Hz)
D   = 0.5;                % Duration (s) : consider 10 periods -- to be completed 
Ax  = 2.7;              % Amplitude for signal x (V)
Ay  = 1.7;              % Amplitude for signal y (V)
phi = -pi/3;             % phase for signal y

% ---- Signal generation

t = 0:Te:D;
N = length(t);          % Number of samples

x = Ax*cos(2*pi*f0*t); % To be completed
y = Ay*cos(2*pi*f0*t+phi);

% ---- Signal display
figure('Name','Intercorrelation')
subplot(2,1,1);
plot(t,x);
hold on;
plot(t,y);
grid on;
title 'Signal x and y - time domain'
legend('x','y')
xlabel 's'
ylabel 'V'

% ----  Intercorrelation
txmax = 1/f0;
[Cxy,tx] = myIntercorrelation(x,y,Fe,txmax);
subplot(2,1,2);
plot(tx,Cxy);
grid on
title 'Intercorrelation of signals x and y'
xlabel 's'
ylabel 'W'

% ---- Retrieve the phase phi
 Cxy_max          = max(Cxy);
 phi_est          = Cxy_max/f0
% 
% fprintf('\nMax of the intercorrelation  = %3.2f',Cxy_max);
% fprintf('\n\tTheoritical value  = %3.2f [2pi]', -- To be completed);
% fprintf('\nEstimated phase  = %3.2f [2pi]',phi_est);
% fprintf('\n\tphi  = %3.2f', phi);



