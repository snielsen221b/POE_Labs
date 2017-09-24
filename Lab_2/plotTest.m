IR_2D = csvread('2D_IR.csv');
v1 = csvread('2D_xpos.csv');

distance = 1/4.*(319-sqrt(5)*sqrt(8000*v1-6359))

xpos = distance.*cosd(XP_2D);
ypos = distance.*sind(XP_2D);

scatter(xpos,ypos,'b.')