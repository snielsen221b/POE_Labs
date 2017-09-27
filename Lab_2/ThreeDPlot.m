IR_3D = csvread('3D_IR.csv');
x_angle = csvread('3D_xpos.csv');
y_angle = csvread('3D_ypos.csv');

[d, e] = Callibration();

distance = polyval(d, IR_3D);

xpos = ones(length(x_angle), 1);
ypos = ones(length(x_angle), 1);
zpos = ones(length(x_angle), 1);

% for i = 1:length(x_angle)
%     for j = 1:length(y_angle)
%         r = distance(i,j);
%         phi = y_angle(j);
%         theta = x_angle(i);
%         zpos(i) = r.*cosd(phi);
%         ypos(i) = r.*sind(phi).*sind(theta);
%         xpos(i) = r.*sind(phi).*cosd(theta); 
%     end
% end

for i = 1:length(x_angle)
    for j = 1:length(y_angle)
        r = distance(i,j);
        phi = y_angle(j);
        theta = x_angle(i);
        ypos(i) = r.*cosd(phi).*sind(theta);
        xpos(i) = r.*cosd(phi).*cosd(theta); 
    end
end

zpos = distance.*sind(y_angle);

figure(3);
    scatter3(xpos,ypos,zpos)