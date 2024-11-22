%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fonction : AutoCorelation
% -------------------------------------------------------------------------
% Description : 
% Cette fonction calcule l'autocorrélation d'un signal donné.
% L'autocorrélation mesure la similitude entre un signal et une version 
% retardée de lui-même pour différents décalages (lags).
%
% Entrées :
%   - x : [vecteur] Le signal d'entrée (domaine temporel).
%
% Sorties :
%   - corr : [vecteur] Valeurs d'autocorrélation pour chaque décalage.
%   - lags : [vecteur] Valeurs des décalages correspondants.
%
% Auteur : G10E
% -------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [corr, lags] = AutoCorelation(x,Fe)
    % x : signal d'entrée
    N = length(x);  
    corr = zeros(1, N);  % Initialisation du vecteur d'autocorrélation

    % Calcul de l'autocorrélation
    for lag = 1:N
        corr(lag) = sum(x(1:N-(lag-1)) .* x(lag:N));  % Somme des produits pour chaque décalage
    end
    
    Te = 1 / Fe;

    lags = (0:N-1) * Te;  % Les lags en secondes
    corr = corr / max(corr);  % Normalisation pour que le pic principal soit à 1

end
