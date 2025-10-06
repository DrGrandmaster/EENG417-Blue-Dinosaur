%
% Plot Results of crane simulation
%
syms phi;
readtable("crane_data.mat");
l_phi = 1/el * zdot - g/el *phi;
l_y = zed - el*phi;



figure
plot(simout,'linewidth',2)
set(gca,'fontsize',14)
legend('r','disturbance','y','x dot')
title('Simulation of crane with controller')

