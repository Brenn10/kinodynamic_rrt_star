clc
clear all

window

% in a 10x10x10 cube
start1 = [start,0,0,0];
goal1  = [stop,0,0,0];
start2 = [stop,0,0,0];
goal2 = [start,0,0,0];

radius = .1;

state_limits = ...
    [world_limits;
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

iterations = 10000;
obstacles = obs;
         
disp(['calculating closed form solution']);
rrt = rrtstar(A,B,c,R,1:3);
disp(['starting algorithm']);

dyn_obs_func = @(t) [];

state_free = @(state, time_range,base_time)(is_state_free(state, state_limits, obstacles, radius, time_range,dyn_obs_func,base_time));
input_free = @(input, time_range)(is_input_free(input, input_limits, time_range));
sample_state = @()(sample_free_states(sampling_limits,state_limits, obstacles, radius));
display = @(scratch, obj, tree, parents, goal, goal_cost, goal_parent)(plot_field(scratch, obj, tree, parents, obstacles, goal, goal_cost, goal_parent));

disp("Running")
[T, parents,iteration_times,iteration_costs,iteration_goal_times] = rrt.run(sample_state, state_free, input_free, start1', goal1', display,iterations);

load trajectory.mat
save("RRT1times.mat",'iteration_times')
save("RRT1goalTimes.mat",'iteration_goal_times')
save("Drone1Traj.mat",'full_path')
save("Drone1Costs.mat",'iteration_costs')
dyn_obs = [full_path(:,1:4),ones(size(full_path,1),3)*radius];
dyn_obs_func = @(t) dynamic_obs(dyn_obs,t);
state_free = @(state, time_range,base_time)(is_state_free(state, state_limits, obstacles, radius, time_range,dyn_obs_func,base_time));
input_free = @(input, time_range)(is_input_free(input, input_limits, time_range));
sample_state = @()(sample_free_states(sampling_limits,state_limits, obstacles, radius));
display = @(scratch, obj, tree, parents, goal, goal_cost, goal_parent)(plot_field(scratch, obj, tree, parents, obstacles, goal, goal_cost, goal_parent));

[T, parents,iteration_times,iteration_costs,iteration_goal_times] = rrt.run(sample_state, state_free, input_free, start2', goal2', display,iterations);
load trajectory.mat
save("RRT2times.mat",'iteration_times')
save("RRT2goalTimes.mat",'iteration_goal_times')
save("Drone2Traj.mat",'full_path')
save("Drone2Costs.mat",'iteration_costs')
