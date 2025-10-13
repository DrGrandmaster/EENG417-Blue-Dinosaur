%% Does the thing

load C.mat;

% Discretize the thing
Ts = 0.1;
C_d = c2d(C, Ts, 'matched');