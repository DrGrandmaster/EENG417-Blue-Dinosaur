%% Design Requirements

% Overshoot
os = 0.01;

% Settling Time
ts = 8;

%% Constants
g = 9.81;
l = 3.7;

%% Model
A = [0 1 0; 0 0 1; 0 -g/l 0];
B = [0 0 1]';
C = [g/l 0 0];

%% Augmented
Aq = [A; -C];
Aq = [Aq, zeros(length(Aq), 1)];
Bqu = [B; 0];
Bqr = [zeros(size(B)); 1];
Bq = Bqu + Bqr;
Cq = [C 0];
Ce = [zeros(size(C)) 1];

%% Poles

% Controller Desired Poles
zeta = (-log(os)) / sqrt(log(os)^2 + pi^2);
wn = 4.6 / (ts * zeta);

des = roots([1 2*zeta*wn wn^2])';

% Controller
cPoles = [des, 100*des];
ePoles = [0.5*des, -100];

%% Gains

% Controller

K_q = place(Aq, Bq, cPoles);
K_x = K_q(1:(end-1));
K_i = K_q(end);

% Estimator
L = place(A', C', ePoles)';

%% Designed System
Ac = [A - B*K_x - L*C -B*K_i; zeros(1, length(A)) 0];
Bc = [zeros(size(L)) L; 1 -1];
Cc = [-K_x -K_i];

Cs = ss(Ac, Bc(:,2), Cc, 0);
Gs = ss(A, B, C, 0);

Cfull = ss(Ac, Bc, Cc, 0);
T = feedback(Gs*Cfull, -1, 2, 1);
T = T(1);

figure(1);
step(T);
grid on;
stepinfo(T)

allmargin(-Cs*Gs)

figure(2);
n = nyquistplot(-Cs*Gs);
grid on;
zoomcp(n);