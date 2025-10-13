%% Performance

load C.mat;

%% Constants

% Gravitational acc'n, m/s^2
g = 9.80665;

% Length of Rope, m
l = 3.7;

%% Linear Plant Model
G = tf([g], [l 0 g 0]);

%% Loop Gain
L = C * G;

%% Closed Loop TF
T = feedback(L, 1);

%% Margins
A = allmargin(L);

%% Bode
[mag, phase, w] = bode(L);
mag = reshape(mag, [length(mag), 1]);
phase = reshape(phase, [length(phase), 1]);
tiledlayout(2, 1, "TileSpacing","tight");

% Mag
nexttile;
semilogx(w, 20*log10(mag));
title('Loop Gain Bode Plot', 'Interpreter','latex');
ylabel("Magnitude / dB", 'Interpreter','latex');
xticks([]);

% Margin stuff
phiM = sprintf('\\(\\circ\\) Phase Margin \\(= %.1f\\,^\\circ\\) \\(\\rightarrow\\)', A.PhaseMargin(1));
text(A.PMFrequency(1), 0, phiM, HorizontalAlignment='right', Interpreter='latex');
hold on;
plot(A.GMFrequency(1), -20*log10(A.GainMargin(1)), '*k');
hold off;

set(gca, 'FontSize', 14);
set(gca, 'TickLabelInterpreter', 'latex');

% Phase

nexttile;
semilogx(w, phase);
ylabel("Phase \(/ ^\circ\)", 'Interpreter','latex');
xlabel("rad \(/\) s", 'Interpreter','latex');

% Margin stuff
gainM = sprintf('* Gain Margin \\(= %.1f\\)\\,dB \\(\\rightarrow\\)', 20*log10(A.GainMargin(1)));
text(A.GMFrequency(1), -180, gainM, HorizontalAlignment='right', Interpreter='latex');
hold on;
plot(A.PMFrequency(1), A.PhaseMargin(1) + 180, 'ok');
hold off;

set(gca, 'FontSize', 14);
set(gca, 'TickLabelInterpreter', 'latex');

%% Step stuff
S = stepinfo(T);