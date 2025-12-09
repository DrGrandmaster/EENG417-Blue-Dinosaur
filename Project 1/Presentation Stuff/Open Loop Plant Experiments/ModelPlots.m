%% Plot the Actual, Non-Linearly Simulated, and Linearly Simulated Responses of the Crane System
load Sim.mat;

plot(out.y_reference, 'g--', 'linewidth', 2);
hold on;
plot(out.y_model, 'r', 'linewidth', 2);
plot(out.y_linear, 'b', 'linewidth', 2);
hold off;
xlim('tight');
xlim('tickaligned');
ylim('padded');
xlabel("t / s", 'Interpreter','latex');
ylabel("y / m", 'Interpreter','latex');
title("Open Loop Plant Pulse-Response", 'Interpreter','latex');
legend(["Experimental Data" "Non-Linear Simulation" "Linear Simulation"], 'Interpreter','latex');
set(gca, 'FontSize', 14);
set(gca, 'TickLabelInterpreter', 'latex');