
j = 13;
i = 13;
r = distance(i,j);
phi = y_angle(j);
theta = x_angle(i);
zpos(i) = r.*cosd(phi);
ypos(i) = r.*sind(phi).*sind(theta);
xpos(i) = r.*sind(phi).*cosd(theta);

for g = 1:41
    phi_g = y_angle(g)
    zpos(g) = r.*sind(phi_g);
end