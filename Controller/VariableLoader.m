%% Loads important variables into your workspace.

%% Constants

% Gravitational acc'n, m/s^2
g = 9.80665;

% Length of Rope, m
l = 3.7;

% Linear Plant Model
G = tf([g], [l 0 g 0]);