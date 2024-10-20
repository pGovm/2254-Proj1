L = 4.5 * 10^(-3);
R_s = 0.1;
R_l = 23.04;
phi = deg2rad(90);
omega = 2*pi*60;
T = 2*pi/omega;
tau = L/(R_s + R_l); %R_l will not be ignored as the switch is open and so current is flowing through it

B = 20.74*sqrt(2)*exp(1i*phi)/(1 + 1i*omega*tau);

d_t = 7*tau/1000; % chose this value as 7*tau/1000 = 1.362 * 10^(-6) while T/1000 = 0.0001067
t = 0: d_t: 2*T; % to show 2 periods in the resultant graph
a = d_t / tau;
b = 1 - a;

v_s = 480*sqrt(2)*cos(omega*d_t + phi); %discretized function
i_l_0 = abs(B)*cos(omega*0 + angle(B))*ones(size(t));
i_s = v_s/(R_s + R_l)*ones(size(t));
i_l = zeros(size(t));

for n = 1:1:length(t) - 1
    if n == 1
        i_l = i_l_0;
    end
    i_l(n+1) = a*i_s(n) + b*i_l(n); %worked out discrete time equation
end

figure(2);
plot(t, i_l)
xlabel('Time:sec');
ylabel('Current: A');