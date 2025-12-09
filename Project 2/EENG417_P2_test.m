plot(out.simout, "blue", "LineWidth", 1.8);

xlabel("Time (s)", "FontSize", 16, "FontWeight", "bold");
ylabel("Output", "FontSize", 16, "FontWeight", "bold");
title("Step Response", "FontSize", 18, "FontWeight", "bold");
legend("Step Response", "FontSize", 14);

grid on;

ax = gca;                     % get current axes
ax.FontSize = 14;             % axis tick labels
ax.LineWidth = 1.5;           % axes border





