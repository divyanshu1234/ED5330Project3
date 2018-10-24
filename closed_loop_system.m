clear all;

ctr_type = 'pi';
is_act_present = 0;
u = 10;
plot_ctrl_output = 1;

% u = 2.5
% unactuated - 12, 0.01
% actuated   - 11, 0.01

% u = 5
% unactuated - 2.5, 0.01
% actuated   - 2.5, 0.01

% u = 10
% unactuated - 1.1, 0.01
% actuated   - 0.9, 0.01

switch ctr_type
    case 'p'
        Kp = 1.1;
        Ki = 0;
        title_str = 'P Controller';
    case 'pi'
        Kp = 1.1;
        Ki = Kp * 0.01;
        title_str = 'PI Controller';
end

s = tf('s');
if is_act_present
    P1_s = get_plant_tr_fn(s, u);
    P2_s = tf(604, [0.044, 9.164, 604]);
    P_s = P1_s * P2_s;
else
    P_s = get_plant_tr_fn(s, u);
end

H_s = 1;

C_s = Kp + Ki/s;
G_s = C_s * P_s;

cl_tr_fn = G_s / (1 + G_s*H_s);

thetaD_deg = 20;
thetaD_rad = deg2rad(thetaD_deg);

t = 0:0.01:5;
in_step = zeros(1, length(t));
in_step(find(abs(t-1)<=0.001):end) = thetaD_rad;

y = plot_response(1, title_str, 'Desired Angle \theta_D (t)', 'Heading Angle \theta (t)', cl_tr_fn, in_step, t);

disp((max(y) - y(end-10)) / y(end-10) * 100);

if plot_ctrl_output
    U_by_R = C_s / (1 + G_s*H_s);
    plot_response(2, title_str, 'Desired Angle \theta_D (t)', 'Steering Angle \delta (t)', U_by_R, in_step, t);
end