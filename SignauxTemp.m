clear 
clc

% ---- Signal parameters
f0  = 1000;             % Sinus frequency (Hz)
Fe  = 20e3;             % Sampling frequency (Hz)
D   = 10 * (1 / f0);    % Duration (s) : 10 periods
A   = 2;                % Amplitude (V)

% ---- Signal generation
Te  = 1/Fe;
t   = 0:Te:D;
x   = A * cos(2 * pi * f0 * t);   % Sinusoidal signal
N   = length(t);                  % Number of samples

% ---- Signal display
figure('Name','Sinus')
plot(t, x);
grid on;
title 'Sinus - time domain'
xlabel 's'
ylabel 'V'

ax = axis;
ax(3) = -1.1 * A; ax(4) = 1.1 * A; axis(ax);

% ---- Signal features in the time domain

xm      = mean(x);            % Mean value
P       = mean(x.^2);         % Mean power
Veff    = sqrt(P);            % RMS value (Root Mean Square)

disp ' ---------------  Sinus '
disp ' ----------------- EXPERIMENTAL VALUES -----------------------'
fprintf('Mean value : %3.2f V', xm);
fprintf('\nMean Power of the signal : %3.2f W', P);
fprintf('\nValeur efficace : %3.2f V\n', Veff);

disp ' ------------------ THEORITICAL VALUES -----------------------'
fprintf('Mean value : %3.2f ', 0);
fprintf('\nMean Power of the signal : %3.2f W', A^2 / 2);
fprintf('\nValeur efficace : %3.2f V\n\n', A/sqrt(2));

disp ' ---------------  max(0,sin) '
disp ' ----------------- EXPERIMENTAL VALUES -----------------------'
x_max_sin = max(0, A * cos(2 * pi * f0 * t)); 
xm_max_sin = mean(x_max_sin); 
P_max_sin = mean(x_max_sin.^2);
Veff_max_sin=sqrt(P_max_sin);

fprintf('Mean value :  %3.2f ', xm_max_sin);
fprintf('\nMean Power of the signal  = %3.2f W', P_max_sin);
fprintf('\nValeur efficace : %3.2f V\n', Veff_max_sin);


disp ' ------------------ THEORITICAL VALUES -----------------------'
fprintf('Mean value : %3.2f ', A/pi);
fprintf('\nMean Power of the signal = %3.2f W', 0.25*A^2);
fprintf('\nValeur efficace : %3.2f V\n\n', A/2);


figure('Name','max')
plot(t, x_max_sin);
grid on;
title 'max(0,sin)'
xlabel 's'
ylabel 'V'

disp ' ---------------  |sin| '
disp ' ----------------- EXPERIMENTAL VALUES -----------------------'
x_abs_sin = abs(A * cos(2 * pi * f0 * t)); % Signal |sin|
xm_abs_sin = mean(x_abs_sin); % Mean value of |sin|
P_abs_sin = mean(x_abs_sin.^2); % Mean power of |sin|
Veff_abs_sin=sqrt(P_abs_sin);

fprintf('Mean value :  %3.2f ', xm_abs_sin);
fprintf('\nMean Power of the signal %3.2f W', P_abs_sin);
fprintf('\nValeur efficace : %3.2f V\n', Veff_abs_sin);

disp ' ------------------ THEORITICAL VALUES -----------------------'
fprintf('Mean value : %3.2f ', 2*A/3.14);
fprintf('\nMean Power of the signal = %3.2f W', 0.5*A^2);
fprintf('\nValeur efficace : %3.2f V\n\n', A/sqrt(2));

figure('Name','abs')
plot(t, x_abs_sin);
grid on;
title 'absolute sin'
xlabel 's'
ylabel 'V'




T0=1/f0;
x4=zeros(size(t));
for i=1:length(t)
    if mod(t(i),T0)<T0/2
        x4(i)=2;
    else
        x4(i)=0.5;
    end 
end 

figure('Name','x4')
plot(t, x4);
grid on;
title 'x4'
xlabel 's'
ylabel 'V'

x4m= mean(x4); % Mean value of |sin|
P_x4m= mean(x4.^2); % Mean power of |sin|
Veff_x4=sqrt(P_x4m);
disp ' ---------------  x4 '
disp ' ----------------- EXPERIMENTAL VALUES -----------------------'
fprintf('Mean value :  %3.2f ', x4m);
fprintf('\nMean Power of the signal %3.2f W', P_x4m);
fprintf('\nValeur efficace : %3.2f V\n', Veff_x4);
disp ' ------------------ THEORITICAL VALUES -----------------------'
fprintf('Mean value : %3.2f ', 1.25);
fprintf('\nMean Power of the signal = %3.2f W', 2.125);
fprintf('\nValeur efficace : %3.2f V', 1.46);


fprintf('\n');

















%input: On rentre la fréquence d'échantillonnage et fondamente,
%la phase initiale, la puissance et la durée d'échantillonnage.
%output:Le signal de sortie ainsi que la puissance.



Fe = 16000; % Fréquence d'échantillonnage en Hz
f0 = 2200;  % Fréquence fondamentale en Hz
phi = pi/3; % Phase initiale en radians
Pdbm = 32;  % Puissance en dBm
duree = 5/f0; % Durée en secondes

% Calcul de l'amplitude B
P = 10^(Pdbm/10) * 1e-3; % Conversion en Watts
B = sqrt(2*P); % Amplitude pour une sinusoïde (puissance moyenne)

% Nombre d'échantillons
N = Fe * duree;

% Création du vecteur de temps
t = 0:1/Fe:(N-1)/Fe;

% Génération du signal
y = B * sin(2*pi*f0*t + phi);

% Affichage du signal
plot(t, y);
xlabel('Temps (s)');
ylabel('Amplitude');
title('Signal sinusoïdal');
grid on;

% Vérification de la puissance (méthode approximative)
P_calculee = mean(y.^2);
Pdbm_calculee = 10*log10(P_calculee*1e3);
disp(['Puissance calculée : ', num2str(Pdbm_calculee), ' dBm']);
