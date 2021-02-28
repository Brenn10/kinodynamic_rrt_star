clc
clear all
% in a 10x10x10 cube

bottleneck

init = [start1,0,0,0,start2,0,0,0];
goal  = [stop1,0,0,0,stop2,0,0,0];

radius = .15

state_limits = ...
    [world_limits;
    -1,1;
    -1,1;
    -1,1];
state_limits = [state_limits;state_limits];

sampling_limits = state_limits;

input_limits = ...
    [ -.9,.9;
      -.9,.9;
      -.7,.7];
input_limits = [input_limits;input_limits];

state_dims = 12;
input_dims = 6;

A= [0,0,0,1,0,0;
    0,0,0,0,1,0;
    0,0,0,0,0,1;
    0,0,0,0,0,0;
    0,0,0,0,0,0;
    0,0,0,0,0,0];
A= blkdiag(A,A);

B= [0,0,0;
    0,0,0;
    0,0,0;
    1,0,0;
    0,1,0;
    0,0,1];
B = blkdiag(B,B);

c = zeros(state_dims,1);

R = eye(input_dims);

iterations = 10000;
obstacles = obs;
         

disp(['calculating closed form solution']);
rrt = rrtstar(A,B,c,R,[1:3,7:9]);
disp(['starting algorithm']);

dyn_obs_func = @(t) [];

state_free = @(state, time_range,base_time)(is_state_free(state, state_limits, obstacles, radius, time_range,dyn_obs_func,base_time));
input_free = @(input, time_range)(is_input_free(input, input_limits, time_range));
sample_state = @()(sample_free_states(sampling_limits,state_limits, obstacles, radius));
display = @(scratch, obj, tree, parents, goal, goal_cost, goal_parent)(plot_field(scratch, obj, tree, parents, obstacles, goal, goal_cost, goal_parent));

disp("Running")
[T, parents,iteration_times,iteration_costs,iteration_goal_times] = rrt.run(sample_state, state_free, input_free, init', goal', display,iterations);

load trajectory.mat
delete trajectory.mat
save("times.mat",'iteration_times')
save("goal_times.mat",'iteration_goal_times')
save("traj.mat",'full_path')
save("cost.mat",'iteration_costs')

