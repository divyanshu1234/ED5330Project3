% Plots the bode diagram and outputs of various inputs
% for the open loop system

clear all;

delta0_deg = 20;
delta0_rad = deg2rad(delta0_deg);
t = 0:0.01:5;

in_pulse = zeros(1, length(t));
in_pulse(abs(t-1.2)<0.2) = delta0_rad*(1 - 1/0.2*abs(t(abs(t-1.2)<0.2)-1.2));

in_step = zeros(1, length(t));
in_step(find(abs(t-1)<=0.001):end) = delta0_rad;

in_sin_1 = delta0_rad * sin(1*t);
in_sin_2 = delta0_rad * sin(2*t);
in_sin_5 = delta0_rad * sin(5*t);

s = tf('s');
P_s = get_plant_tr_fn(s, 2.5);
figure(1);
bode(P_s);
plot_response(2, 'Pulse', 'Steer Angle \delta (t)', 'Heading Angle \theta (t)', P_s, in_pulse, t);
plot_response(3, 'Step', 'Steer Angle \delta (t)', 'Heading Angle \theta (t)',  P_s, in_step, t);
plot_response(4, 'Sin 1 rad/s', 'Steer Angle \delta (t)', 'Heading Angle \theta (t)',  P_s, in_sin_1, t);
plot_response(5, 'Sin 2 rad/s', 'Steer Angle \delta (t)', 'Heading Angle \theta (t)',  P_s, in_sin_2, t);
plot_response(6, 'Sin 5 rad/s', 'Steer Angle \delta (t)', 'Heading Angle \theta (t)',  P_s, in_sin_5, t);
