%% simultaneous
load window_3\simultaneous\traj.mat
d1 = full_path(:,1:7);
d2 = full_path(:,[1,8:13]);
d3 = full_path(:,[1,14:19]);

% TODO: Add a collision check here
figure(1)
% patch([d1(:,2);nan],[d1(:,3);nan],[d1(:,4);nan],[d1(:,1)/max(d1(:,1));nan],'EdgeColor','interp','FaceColor','none','LineWidth',5);
% hold on;
% patch([d2(:,2);nan],[d2(:,3);nan],[d2(:,4);nan],[d2(:,1)/max(d2(:,1));nan],'EdgeColor','interp','FaceColor','none','LineWidth',5);
% hold on;
% patch([d3(:,2);nan],[d3(:,3);nan],[d3(:,4);nan],[d3(:,1)/max(d3(:,1));nan],'EdgeColor','interp','FaceColor','none','LineWidth',5);
plot3(d1(:,2),d1(:,3),d1(:,4),'b','LineWidth',3);
hold on;
plot3(d2(:,2),d2(:,3),d2(:,4),'g','LineWidth',3);
hold on;
plot3(d3(:,2),d3(:,3),d3(:,4),'c','LineWidth',3);
plot3([-.25,-.25],[-.5,-1],[3,3],'k','LineWidth',5)
xlim([-1.5,1])
ylim([-1.5,1])
view(2)
saveas(gcf,"simultaneous.png")
%% Sequential
load window_3\sequential\Drone1Traj.mat
d1 = full_path;
load window_3\sequential\Drone2Traj.mat
d2 = full_path;
load window_3\sequential\Drone3Traj.mat
d3 = full_path;

% TODO: Add a collision check here
figure(2)
% patch([d1(:,2);nan],[d1(:,3);nan],[d1(:,4);nan],[d1(:,1)/max(d1(:,1));nan],'EdgeColor','interp','FaceColor','none','LineWidth',5);
% hold on;
% patch([d2(:,2);nan],[d2(:,3);nan],[d2(:,4);nan],[d2(:,1)/max(d2(:,1));nan],'EdgeColor','interp','FaceColor','none','LineWidth',5);
% hold on;
% patch([d3(:,2);nan],[d3(:,3);nan],[d3(:,4);nan],[d3(:,1)/max(d3(:,1));nan],'EdgeColor','interp','FaceColor','none','LineWidth',5);
plot3(d1(:,2),d1(:,3),d1(:,4),'b','LineWidth',3);
hold on;
plot3(d2(:,2),d2(:,3),d2(:,4),'g','LineWidth',3);
hold on;
plot3(d3(:,2),d3(:,3),d3(:,4),'c','LineWidth',3);
plot3([-.25,-.25],[-.5,-1],[3,3],'k','LineWidth',5)
xlim([-1.5,1])
ylim([-1.5,1])
view(2)
saveas(gcf,"sequential.png")