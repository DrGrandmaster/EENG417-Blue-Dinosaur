
%set up state space representation
g = 9.81;
l = 3.7;

A = [0 1 0; 0 0 1; 0 -g/l 0];
B = [0; 0; 1];
C = [g/l 0 0];
D = 0;

%create system
sys = ss(A,B,C,D);


%determine K and L poles with L being 2 times faster than K 
Poles_K = [(-3.74+j*3), (-3.74-j*3), -20];
Poles_L = 4*Poles_K;


%determine K and L
K = place(A,B, Poles_K);
L = place(A',C', Poles_L)';



%set up new System with K and L
Acl = [A -B*K ; L*C A-B*K-L*C];
Bcl = [B;B];
Ccl = [C zeros(1,3)];

N = 1 / (C * inv(-A + B*K) * B);

LQR_sys = ss(Acl,Bcl,Ccl,D);

INFO = stepinfo(LQR_sys);
step(LQR_sys)