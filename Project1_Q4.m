clear all;
fileID = fopen('problem4.bin', 'r'); % From problem 3
x_in = fread(fileID, 'single');
fclose(fileID);

x = x_in(1:2:end) + 1i * x_in(2:2:end); % Basically gives me R1, I1, R2, I2...

% Given constants
Fs = 2.205*10^6;
f = 50000; 
delta_t = 1 / Fs;

t = ((0:length(x)-1) * delta_t)'; % Transposed time vector

x3 = exp(-1i * 2 * pi * f * t); % Value of x3

x_out = x .* (x3); % Elementwise operation

sound(downsample(real(x_out), 100), 22.05e3); % Real part of x_out
sound(downsample(imag(x_out), 100), 22.05e3); % Imaginary part of x_out