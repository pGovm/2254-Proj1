clear all
load('sampleaudio.mat'); % Loads audio file
% Constants given
R = 1;
C = (265.26*10^-6);
delta_t = 1/Fs; % Given and Fs is supplied by .mat file
L = length(x); % Length of the audio signal
t = (0:1:L-1); % Time vector
tau = R*C; % Calculated time constant for RC circuit
a = (delta_t/tau);
% Used to initialize the output signal
z = ones(size(t));
y = ones(size(t));
y(1) = x(1);
% Loop for high-pass filter
for n=2:length(x)
    y(n) = (y(n-1)+x(n)-x(n-1))/(1 + a);
end

sound(y, Fs); % Play the filtered audio

figure;
subplot(2,1,1); % First subplot for original audio
plot(t, x);
title('Original Audio');
xlabel('Time: sec');
ylabel('Amplitude: Hz');

subplot(2,1,2); % Second subplot for filtered audio
plot(t, y);
title('Filtered Audio');
xlabel('Time: sec');

%If you only knew the power of the dark side