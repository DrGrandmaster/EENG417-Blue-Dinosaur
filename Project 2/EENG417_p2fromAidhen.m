%% specifications
OS = 0.12;          % percent overshoot 
Ts = 4.5;           % settling time (2% criterion)

%% compute damping ratio zeta from overshoot
zeta = -log(OS) / sqrt(pi^2 + (log(OS))^2);

%% compute natural frequency wn from settling time
wn = 4 / (zeta * Ts);

%% generate dominant closed-loop poles
sigma = zeta * wn;                           % real part
wd = wn * sqrt(1 - zeta^2);                 % imaginary part

p1 = -sigma + 1j*wd;
p2 = -sigma - 1j*wd;

% choose 3rd pole faster so it is non-dominant
p3 = -5*sigma;

desired_poles = [p1 p2 p3];

disp("Dominant Closed-loop Poles:");
disp(desired_poles);



%% set up state space representation
g = 9.81;
l = 3.7;

A = [0 1 0; 0 0 1; 0 -g/l 0];
B = [0; 0; 1];
C = [g/l 0 0];

D = 0;

%create system
sys = ss(A,B,C,D);

%determine K and L poles with L being 2 times faster than K
% Poles_K = [(-3.74+j*3), (-3.74-j*3), -20];
% Ts 9
%Poles_K = [(-0.4444 + 0.8675i), (-0.4444 - 0.8675i), (-2.2222 + 0.0000i)];
% Ts 10 OS 0.3
%Poles_K = [(-0.4000 + 1.0437i), (-0.4000 - 1.0437i), (-2.0000 + 0.0000i)];
% Ts 16
% Poles_K = [(-0.2500 + 0.4880i), (-0.2500 - 0.4880i), (-1.2500 + 0.0000i)];
%Ts 4
%Poles_K = [(-1.0000 + 1.9520i), (-1.0000 - 1.9520i), (-5.0000 + 0.0000i)];
% OS .15 Ts 5.5
%Poles_K = [(-0.7273 + 1.2043i), (-0.7273 - 1.2043i), (-3.6364 + 0.0000i)];
% OS .15 Ts 5
%Poles_K = [(-0.8000 + 1.3248i), (-0.8000 - 1.3248i), (-4.0000 + 0.0000i)];
% os .12 ts 4.5
%Poles_K = []


% Estimator poles (real part *4)
%Poles_L = [-14.96+3j, -14.96-3j, -80];
Poles_L = 4*Poles_K;

%saturate the input to prevent for asking for too high a speed
% lower settling time
 
%determine K and L
K = place(A,B, Poles_K);
L = place(A',C', Poles_L)';
 
%set up new System with K and L
Acl = [A -B*K ; L*C A-B*K-L*C];
Bcl = [B;B];
Ccl = [C zeros(1,3)];

% N = ((C-D*K)*(B*K-A)^-1 *B+D)^-1;
% N = -1/(C*((A-B*K)\B));
N = Ccl*(-Acl)^-1*Bcl;

%Acl = [A - B*K,       B*K;
%       zeros(3,3),    A - L*C];
%Bcl = [B*N;
%       zeros(3,1)];
%Ccl = [C  zeros(1,3)];




LQR_sys = ss(Acl,Bcl,Ccl,D);

 
INFO = stepinfo(LQR_sys);
step(LQR_sys)

 
% Poles_K= [(-0.8000 + 0.6424i), (-0.8000 - 0.6424i), (-4.0000 + 0.0000i)];
%Poles_K = [(-0.8000 + 1.5616i), (-0.8000 - 1.5616i), (-4.0000 + 0.0000i)];
%Poles_K = [(-0.5000 + 0.9760i), (-0.5000 - 0.9760i), (-2.5000 + 0.0000i)];
%Poles_K = [(-0.4000 + 0.7808i), (-0.4000 - 0.7808i), (-2.0000 + 0.0000i)];
 %Poles_K = [(-0.3333 + 0.6507i), (-0.3333 - 0.6507i), (-1.6667 + 0.0000i)];



