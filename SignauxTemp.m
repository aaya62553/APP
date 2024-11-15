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

disp ' ----------------- EXPERIMENTAL VALUES -----------------------'
disp(sprintf('Mean value : %3.2f V', xm));
disp(sprintf('Mean Power of the signal : %3.2f W', P));
disp(sprintf('RMS value : %3.2f V', Veff));

disp ' ------------------ THEORITICAL VALUES -----------------------'
disp ' ---------------  Sinus '
disp(sprintf('Mean value : %3.2f ', 0));
disp(sprintf('Mean Power of the signal A^2/2 = %3.2f W', A^2 / 2));

disp ' ------------------ OTHER SIGNALS-----------------------'
% Do the same for the other signals
disp ' ---------------  max(0,sin) '
x_max_sin = max(0, A * cos(2 * pi * f0 * t)); % Signal max(0, sin)
xm_max_sin = mean(x_max_sin); % Mean value of max(0, sin)
P_max_sin = mean(x_max_sin.^2); % Mean power of max(0, sin)

figure('Name','max')
plot(t, x_max_sin);
grid on;
title 'max(0,sin)'
xlabel 's'
ylabel 'V'
fprintf('\nMean value :  %3.2f ', xm_max_sin);
fprintf('\nMean Power of the signal  = %3.2f W', P_max_sin);

disp ' ---------------  |sin| '
x_abs_sin = abs(A * cos(2 * pi * f0 * t)); % Signal |sin|
xm_abs_sin = mean(x_abs_sin); % Mean value of |sin|
P_abs_sin = mean(x_abs_sin.^2); % Mean power of |sin|

figure('Name','abs')
plot(t, x_abs_sin);
grid on;
title 'absolute sin'
xlabel 's'
ylabel 'V'


fprintf('\nMean value :  %3.2f ', xm_abs_sin);
fprintf('\nMean Power of the signal %3.2f W', P_abs_sin);

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
disp ' ---------------  x4 '
fprintf('\nMean value :  %3.2f ', x4m);
fprintf('\nMean Power of the signal %3.2f W', P_x4m);



fprintf('\n');
