IR_3D = csvread('3D_IR.csv');
x_angle = csvread('3D_xpos.csv');
y_angle = csvread('3D_ypos.csv');

[d, e] = Callibration();

distance = polyval(d, IR_3D);

%xpos = distance.*cosd(x_angle).*cosd(y_angle);
%ypos = distance.*sind(x_angle).*cosd(y_andgle);
%zpos = distance.*sind(y_angle);

xpos = zeros(length(x_angle), 1);
ypos = zeros(length(x_angle), 1);
zpos = zeros(length(x_agnle), 1);

for i = 1:length(x_angle)
    for j = 1:length(y_angle)
        r = distance(i,j);
        zpos(i) = r*sind(y_angle(j));
    end
end
