clc
clear all
% in a 10x10x10 cube
start = [1,5,5,0,0,0];
goal  = [9,5,5,0,0,0];

radius = .2;

state_limits = ...
    [0,10;
    0,10;
    0,10;
    -1,1;
    -1,1;
    -1,1];

sampling_limits = state_limits;

input_limits = ...
    [ -1,1;
      -1,1;
      -1,1];

state_dims = 6;
input_dims = 3;

A= [0,0,0,1,0,0;
    0,0,0,0,1,0;
    0,0,0,0,0,1;
    0,0,0,0,0,0;
    0,0,0,0,0,0;
    0,0,0,0,0,0];

B= [0,0,0;
    0,0,0;
    0,0,0;
    1,0,0;
    0,1,0;
    0,0,1];

c = zeros(state_dims,1);

R = eye(3);

obstacles = [4,6,0,1,4,10;
             4,0,0,1,4,10;
             4,0,0,1,10,4;
             4,0,6,1,10,4];
         
disp(['calculating closed form solution']);
rrt = rrtstar(A,B,c,R,1:3);
disp(['starting algorithm']);

dyn_obs_func = @(t) [];

state_free = @(state, time_range,base_time)(is_state_free(state, state_limits, obstacles, radius, time_range,dyn_obs_func,base_time));
input_free = @(input, time_range)(is_input_free(input, input_limits, time_range));
sample_state = @()(sample_free_states(sampling_limits,state_limits, obstacles, radius));
display = @(scratch, obj, tree, parents, goal, goal_cost, goal_parent)(plot_field(scratch, obj, tree, parents, obstacles, goal, goal_cost, goal_parent));

disp("Running")
[T, parents,iteration_times,iteration_costs] = rrt.run(sample_state, state_free, input_free, start', goal', display,500);

load trajectory.mat
save("RRT1times.mat",'iteration_times')
save("Drone1Traj.mat",'full_path')
save("Drone1Costs.mat",'iteration_costs')
dyn_obs = [full_path(:,1:4),ones(size(full_path,1),3)*radius];
goal = [1,5,5,0,0,0];
start  = [9,5,5,0,0,0];
dyn_obs_func = @(t) dynamic_obs(dyn_obs,t);
state_free = @(state, time_range,base_time)(is_state_free(state, state_limits, obstacles, radius, time_range,dyn_obs_func,base_time));
input_free = @(input, time_range)(is_input_free(input, input_limits, time_range));
sample_state = @()(sample_free_states(sampling_limits,state_limits, obstacles, radius));
display = @(scratch, obj, tree, parents, goal, goal_cost, goal_parent)(plot_field(scratch, obj, tree, parents, obstacles, goal, goal_cost, goal_parent));

[T, parents,iteration_times,iteration_costs] = rrt.run(sample_state, state_free, input_free, start', goal', display,500);
load trajectory.mat
save("RRT2times.mat",'iteration_times')
save("Drone2Traj.mat",'full_path')
save("Drone2Costs.mat",'iteration_costs')
