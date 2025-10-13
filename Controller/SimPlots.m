%% Plot the Step Response of the Crane Control System
load Sim.mat;

%colororder(["black" "green", "red", "blue"]);
yyaxis left
plot(out.y, 'k-', 'linewidth', 2);
hold on;
plot(out.r, 'g-', 'linewidth', 2);
plot(out.e, 'r-', 'linewidth', 2);
hold off;
xlim('tight');
xlim('tickaligned');
ylim('padded');
xlabel("t / s", 'Interpreter','latex');
ylabel("y / m", 'Interpreter','latex');
yyaxis right;
plot(out.u, 'b-', 'linewidth', 2);
ylabel("$\dot{z}$ / m/s", 'Interpreter','latex');
xlabel("t / seconds");
title("Closed Loop Crane Control-System Response", 'Interpreter','latex');
legend(["System Output" "Target" "Error" "Hoist Velocity"], 'Interpreter','latex');
set(gca, 'FontSize', 14);
set(gca, 'TickLabelInterpreter', 'latex');