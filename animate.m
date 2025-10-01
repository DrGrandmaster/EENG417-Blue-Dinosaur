%
% Animation of crane system simulation
% Hoist position and crane angle with respect to vertical
% should be saved in timeseries
%
Tx=5; % speed of simulation relative to real time
for i=1:length(x_and_phi.time)-1
    x=x_and_phi.data(i,1);
    theta=x_and_phi.data(i,2);
    plot(x,0,'o',x-l*sin(theta),-l*cos(theta),'o')
    line([x x-l*sin(theta)],[0 -l*cos(theta)])
    axis([-2 6 -3 1])
    axis equal
    title([num2str(Tx),'x speed animation'])
    drawnow
    pause((simout.Time(i+1)-simout.Time(i))/Tx);
end
    