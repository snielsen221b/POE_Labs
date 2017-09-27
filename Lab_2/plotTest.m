IR_2D = csvread('2D_IR.csv');
x_angle = csvread('2D_xpos.csv');
sizex = size(x_angle);
[d, e] = Callibration();
xline = linspace(-100,100);

distance = polyval(d, IR_2D);

xpos = distance.*cosd(x_angle);
ypos = distance.*sind(x_angle);

figure(3)
    clf
    hold on
    plot(xpos,ypos,'b--o')
    plot(xline,ones(length(xline)).*65,'k')
    plot(xpos(40),ypos(40),'r.','markers',35)
    ylim([20 80])
    xlabel('X Position (cm)')
    ylabel('Y Position (cm)')
    legend('Raw Data','Wall Location','Location of "Z"','Location','Southeast')
    title('Detecting Location of "Z" in 2D-Scan')