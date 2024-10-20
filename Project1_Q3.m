clear all
fileID = fopen('problem3.bin','r'); % Loads in audio file
x = fread(fileID,'single'); % Reads data as single precision
fclose(fileID); % closes file after it reads it all

Fs = (2.205*10^6);      % FS value given
f = 50000;         % Frequency given
delta_t = 1 / Fs; 
L = length(x); % Length of the audio signal
Lh = 1.6*10-3; % Value of inductor
Ca = 1*10^-6; % Value of capacitor
R=28.135; % Resistor value

b = (1/(R*Ca)); % B from characteristic equation

t = (0:L-1) * delta_t;  % Time vector
c = cos(2*pi*f*t);  % Carrier signal

x_d = x' .* c;  % I transposed x to ensure I got a row vector

L_signal = length(x); % Length of the input signal
t = (0:L-1) * delta_t; % Time vector
% Initializing values for output signal
y1 = ones(size(t));
y2 = ones(size(t));
y1_0 = 0; 
y2_0 = 0;

for n = 1:1:length(t)-1
    if n == 1
        y1(1) = y1_0; % Inital conditions set
        y2(1) = y2_0; % Inital conditions set
    else
        y1(n+1) = y1(n) + delta_t *y2(n); % From Euler's forward method
        y2(n+1) = delta_t*(x(n) - b*y2(n) - y1(n)/Ca)/Lh + y2(n);
    end
end

sound(downsample(y1, 100), 22.05e3); % Downsampled y(t)
sound(downsample(x_d, 100), 22.05e3); % Downsampled x_out(t)

t_s1 = 10.5; % Start
t_e1 = 10.6; % End
n_s1 = round(t_s1 / delta_t); % Rounded for array values so warning went away
n_e1 = round(t_e1 / delta_t); % Rounded for array values so warning went away

figure;
subplot(2,1,1);
plot(t(n_s1:n_e1), x(n_s1:n_e1), 'b', t(n_s1:n_e1), x_d(n_s1:n_e1), 'r');
title('Graph 1: x(t) and x_out(t) from 10.5s to 10.6s');
xlabel('Time (s)');
ylabel('Amplitude');
legend('x(t)', 'x_out(t)');

T = 1 / f;  % Period of the carrier
t_s2 = 10.6;
n_s2 = round(t_s2 / delta_t); % Rounded for array values so warning went away
n_e2 = n_s2 + round(2 * T / delta_t); % Rounded for array values so warning went away

subplot(2,1,2);
plot(t(n_s2:n_e2), x(n_s2:n_e2), 'b', t(n_s2:n_e2), x_d(n_s2:n_e2), 'r');
title('Graph 2: x(t) and x_out(t) for two periods of the carrier');
xlabel('Time (s)');
ylabel('Amplitude');
legend('x(t)', 'x_out(t)');

