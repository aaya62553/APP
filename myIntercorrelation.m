%% Compute normalized cross-correlation of x and y
%  Inputs
%       x,y  : Input signals
%       Fe   : Sampling frequency of x and y
%       txmax: max shift of y (compute Cxy for tx = 0 -> txmax
%  Outputs
%       Cxy : cross-correlation - as a function of tx
%       tx  :time vector 
% -------------------------------------------------------------------------
function [Cxy,tx] = myIntercorrelation(x,y,Fe,txmax)

kmax =200;
Nx   = length(x);
Ny   = length(y);

Cxy  = zeros(1,kmax+1);
for k = 0:kmax
    ys = [ y(1:Ny-k) zeros(1,Nx-(Ny-k))];   % pad with zeros to get the same length as x
    Cxy(k+1) = sum(x.*ys);
end
tx = (0:kmax)/Fe;


    