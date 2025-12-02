%% Plot the Actual, Non-Linearly Simulated, and Linearly Simulated Responses of the Crane System
load Sim.mat;

colororder(["green", "red", "blue"]);
plot(out.y_reference, '--', 'linewidth', 2);
hold on;
plot(out.y_model, 'linewidth', 2);
plot(out.y_linear, 'linewidth', 2);
hold off;
xlim('tight');
xlim('tickaligned');
ylim('padded');
xlabel("t / seconds");
ylabel("y / meters");
title("Experimental and Simulation Responses");
legend(["Experimental Data" "Non-Linear Simulation" "Linear Simulation"]);