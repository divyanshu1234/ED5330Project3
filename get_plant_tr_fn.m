function P_s = get_plant_tr_fn(s, u)
% Returns the plant transfer function
% Parameter:
% u - Longitudinal velocity
% s - Laplace variable

L = 2;
Lf = 1.2;
Lr = L - Lf;
m = 1000;
Iz = 960;
Cf = 35973;
Cr = 53959;

A_11 = -(Cf + Cr) / (m*u);
A_12 = (-Lf*Cf + Lr*Cr) / (m*u) - u;
A_21 = -(Lf*Cf - Lr*Cr) / (Iz*u);
A_22 = -(Lf^2*Cf + Lr^2*Cr) / (Iz*u);

A = [A_11, A_12; A_21, A_22];
b = [Cf/m; Lf*Cf/Iz];
c = [0, 1];

[p1, p2] = ss2tf(A, b, c, 0);
P_s = tf(p1, p2) / s;  % dividing by s to get theta by delta

end