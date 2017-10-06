IR_3D = csvread('3D_IR.csv');
x_angle = csvread('3D_xpos.csv');
y_angle = csvread('3D_ypos.csv');

% [d, e] = Callibration();

true3D = IR_3D(1:41,:)
distance = polyval(d, true3D);

xpos = [];
ypos = [];
zpos = [];

for i = 1:length(x_angle)
    for j = 1:length(y_angle)
        r = distance(i,j);
        phi = y_angle(j);
        theta = x_angle(i);
        zpos = [zpos,r.*sind(phi)];
        ypos = [ypos,r.*cosd(phi).*sind(theta)];
        xpos = [xpos,r.*cosd(phi).*cosd(theta)]; 
    end
end

figure(3);
% for i = 1:size(distance(:,1))
%     hold on
%     plot3(x_angle,y_angle,distance(:,i),'b.')
%     axis([-100 100 -100 100 -100 100])
% end
    plot3(xpos,ypos,zpos,'b.')
    axis([-100 100 -100 100 -100 100])
    xlabel('X Position')
    ylabel('Y Position')
    zlabel('Z Position')
    title('Scatterplot of 3D Datapoints')