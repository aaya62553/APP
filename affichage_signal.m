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