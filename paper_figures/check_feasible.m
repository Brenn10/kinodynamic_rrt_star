%% Clear and close everything
clear; close all; clc;

%% Tello model
dt = 0.05;

ax_pv = dt;
ax_vv = 1;
bx_v  = 0.05;

ay_pv = dt;
ay_vv = 1;
by_v  = 0.05;

az_pv = dt;
az_vv = 1;
bz_v  = 0.05;
%% Load Trajectory and add time
load('no_obstacle\sequential\Drone1Traj.mat','full_path');
traj = full_path;
traj_t = 0.05 * (0 : (length(traj) - 1));

%% Check if it's feasible according to the model
is_feasible = 1;

feasible_traj = zeros(size(traj));
feasible_traj(1, :) = traj(1, :);

u_traj = zeros([size(traj,1), 3]);

for i = 2 : length(traj)
    % X axis
    u = (traj(i, 4) - ax_vv * feasible_traj(i-1, 4)) / bx_v;
    [u, in_bounds] = clip_u(u);
    is_feasible = is_feasible & in_bounds;
    feasible_traj(i, 4) = ax_vv * feasible_traj(i-1, 4) + bx_v * u;
    feasible_traj(i, 1) = feasible_traj(i-1, 1) + ax_pv * feasible_traj(i-1, 4);
    u_x = u;
    
    % Y axis
    u = (traj(i, 5) - ay_vv * feasible_traj(i-1, 5)) / by_v;
    [u, in_bounds] = clip_u(u);
    is_feasible = is_feasible & in_bounds;
    feasible_traj(i, 5) = ay_vv * feasible_traj(i-1, 5) + by_v * u;
    feasible_traj(i, 2) = feasible_traj(i-1, 2) + ay_pv * feasible_traj(i-1, 5);
    u_y = u;
    
    % Z axis
    u = (traj(i, 6) - az_vv * feasible_traj(i-1, 6)) / bz_v;
    [u, in_bounds] = clip_u(u);
    is_feasible = is_feasible & in_bounds;
    feasible_traj(i, 6) = az_vv * feasible_traj(i-1, 6) + bz_v * u;
    feasible_traj(i, 3) = feasible_traj(i-1, 3) + az_pv * feasible_traj(i-1, 6);
    u_z = u;
    
    u_traj(i - 1, :) = [u_x, u_y, u_z];    
end

figure
subplot(3, 1, 1)
hold on
plot(traj_t, traj(:, 1), 'r')
plot(traj_t, feasible_traj(:, 1), 'b')
hold off
subplot(3, 1, 2)
hold on
plot(traj_t, traj(:, 2), 'r')
plot(traj_t, feasible_traj(:, 2), 'b')
hold off
subplot(3, 1, 3)
hold on
plot(traj_t, traj(:, 3), 'r')
plot(traj_t, feasible_traj(:, 3), 'b')
hold off

figure
subplot(3, 1, 1)
hold on
plot(traj_t, traj(:, 4), 'r')
plot(traj_t, feasible_traj(:, 4), 'b')
hold off
subplot(3, 1, 2)
hold on
plot(traj_t, traj(:, 5), 'r')
plot(traj_t, feasible_traj(:, 5), 'b')
hold off
subplot(3, 1, 3)
hold on
plot(traj_t, traj(:, 6), 'r')
plot(traj_t, feasible_traj(:, 6), 'b')
hold off

figure
subplot(3, 1, 1)
plot(traj_t, u_traj(:, 1), 'r')
subplot(3, 1, 2)
plot(traj_t, u_traj(:, 2), 'r')
subplot(3, 1, 3)
plot(traj_t, u_traj(:, 3), 'r')

function [u_bounded, in_bounds] = clip_u(u)
u_bounded = u;
in_bounds = 1;
if u > 1
    u_bounded = 1;
    in_bounds = 0;
elseif u < -1
    u_bounded = -1;
    in_bounds = 0;
end
end








