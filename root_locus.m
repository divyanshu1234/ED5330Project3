clear all;

ctr_type = 'p';
is_act_present = 1;
u = 10;

beta_deg = 53.77;
beta_rad = deg2rad(beta_deg);

switch ctr_type
    case 'p'
        Ki_Kp = 0;
    case 'pi'
        Ki_Kp = 0.01;
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

C_s = 1 + Ki_Kp/s;
G_s = C_s * P_s;

op_tr_fn = G_s * H_s;

rlocus(op_tr_fn);
% title('')
hold on;
plot([0 -100], [0 100*tan(beta_rad)], 'black', [0 -100], [0 -100*tan(beta_rad)], 'black');