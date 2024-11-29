%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Probleme 3
% -------------------------------------------------------------------------
% Description : 
% fichier MATLAB associé au probleme 3
%
%
%
% Auteur : G10E
% -------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc



function [debit, taille,SurUnCD] = probleme3(frequence,bits)
debit =frequence*bits;
taille = debit*3600;
if taille >= 700e6*8;
    SurUnCD = false;
else
    SurUnCD = true;
end
end

