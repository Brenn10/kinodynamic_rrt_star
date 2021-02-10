load Drone1Traj.mat
d1 = full_path
load Drone2Traj.mat
d2 = full_path

colormap(hsv)
p1=patch([d1(:,2);nan],[d1(:,3);nan],[d1(:,4);nan],[d1(:,1);nan],'FaceColor','none','EdgeColor','interp','LineWidth',3);
hold on;
p2=patch([d2(:,2);nan],[d2(:,3);nan],[d2(:,4);nan],[d2(:,1);nan],'FaceColor','none','EdgeColor','interp','LineWidth',3);
xlim([0 10])
ylim([0 10])
zlim([0 10])
colorbar

collision = false;
for d1i=1:size(d1,1)
    [d2t,d2i] = min(abs(d2(:,1)-d1(d1i,1)));
    if sqrt(sum((d1(d1i,2:4)-d2(d2i,2:4)).^2))<.2
        fprintf("Collision at t=%f\n",d1(d1i,1))
        collision = true;
    end
end
if(~collision)
    disp("No Collisions")
end