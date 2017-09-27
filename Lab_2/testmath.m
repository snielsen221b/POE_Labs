
j = 13;
i = 13;
r = distance(i,j);
phi = y_angle(j);
theta = x_angle(i);
zpos(i) = r.*sind(phi);
ypos(i) = r.*cos(phi).*sind(theta);
xpos(i) = r.*cosd(phi).*cosd(theta); 