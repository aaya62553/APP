%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fonction : SignalUtile
% -------------------------------------------------------------------------
% Description : 
% Cette fonction identifie les segments actifs d'un signal audio en se 
% basant sur son énergie. Elle retourne les indices temporels de début et 
% de fin de ces segments en secondes.
%
% Entrées :
%   - audioSignal : [vecteur] Signal audio à analyser.
%   - Fe : [scalaire] Fréquence d'échantillonnage du signal (en Hz).
%
% Sorties :
%   - startIdxSec : [vecteur] Temps de début des segments actifs (en secondes).
%   - endIdxSec : [vecteur] Temps de fin des segments actifs (en secondes).
%
% Auteur : G10E
% -------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



function [startIdxSec,endIdxSec]=SignalUtile(audioSignal,Fe)

% Étape 2 : Détection des segments actifs
winSize = round(0.02 * Fe); % Fenêtre de 20 ms
hopSize = round(0.01 * Fe); % Recouvrement de 50 %
pSeuil = 0.008; % Seuil d'énergie (ajuster selon les données)

startIdx = [];
endIdx = [];
isActive = false;

%Segment du signal de 10ms
for i = 1:hopSize:(length(audioSignal) - winSize)
    segment = audioSignal(i:i + winSize - 1);
    p = sum(segment .^ 2) / winSize;

    if p > pSeuil
        if ~isActive
            startIdx = [startIdx, i]; % Début d'un segment actif
            isActive = true;
        end
    else
        if isActive
            endIdx = [endIdx, i + winSize - 1]; % Fin d'un segment actif
            isActive = false;
        end
    end
end
% Si le dernier segment actif n'a pas de fin
if isActive
    endIdx = [endIdx, length(audioSignal)];
end

startIdxSec=startIdx'/Fe;
endIdxSec=endIdx'/Fe;
end
