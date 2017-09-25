IR_2D = csvread('2D_IR.csv');
x_angle = csvread('2D_xpos.csv');
sizex = size(x_angle);
[d, e] = Callibration();

distance = polyval(d, IR_2D);

xpos = distance(10:30).*cosd(x_angle(10:30));
ypos = distance(10:30).*sind(x_angle(10:30));

figure(3)
    clf
    plot(xpos,ypos,'b.')