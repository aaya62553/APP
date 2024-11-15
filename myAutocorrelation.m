%% Compute normalized cross-correlation of x and y
%  Inputs
%       x    : Input signal
%       Fe   : Sampling frequency of x and y
%       D    : duration for computing the autocorrelation and max shift
%  Outputs
%       Cxx : autocorrelation - as a function of tx
%       tx  : time vector 
% -------------------------------------------------------------------------
function [Cxx,tx] = myAutocorrelation(x,Fe,D)
    kmax = round(D*Fe);
    Nx   = length(x);
    if Nx<2*kmax
        fprintf('ERROR : duration of x < 2*D !')
        Cxx = [];
        tx  = [];
    else
        x0   = x(1:kmax);
        Cxx  = zeros(1,kmax);
        for k = 0:kmax-1
            
            xs       = x(k+1:min(kmax+k, Nx));   
            Cxx(k+1) = mean(x0.*xs);
        end
        tx = (0:kmax-1)/Fe;
    end
end


    