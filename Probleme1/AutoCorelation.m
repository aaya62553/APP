
function [corr, lags] = AutoCorelation(x)
    % x : signal d'entrée
    N = length(x);  % Longueur du signal
    corr = zeros(1, N);  % Initialisation du vecteur d'autocorrélation

    % Calcul de l'autocorrélation
    for lag = 0:N-1
        corr(lag+1) = sum(x(1:N-lag) .* x(lag+1:N));  % Somme des produits pour chaque décalage
    end
    
    % Générer le vecteur des lags (décalages temporels)
    Te = 1 / 48000;  % Exemple pour une fréquence d'échantillonnage de 48 kHz

    lags = (0:N-1) * Te;  % Les lags en secondes
    corr = corr / max(corr);  % Normalisation pour que le pic principal soit à 1

end