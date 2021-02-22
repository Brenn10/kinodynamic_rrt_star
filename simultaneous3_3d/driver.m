clc
clear all
% in a 10x10x10 cube

scale = 10;
start = [1,5,5,0,0,0,9,5,5,0,0,0,5,9,5,0,0,0]./scale;
goal  = [9,5,5,0,0,0,5,9,5,0,0,0,1,5,5,0,0,0]./scale;

radius = .2/scale;
state_limits = ...
    [0,10/scale;
    0,10/scale;
    0,10/scale;
    -1,1;
    -1,1;
    -1,1];
state_limits = [state_limits;state_limits;state_limits];

sampling_limits = state_limits;

input_limits = ...
    [ -1,1;
      -1,1;
      -1,1];
input_limits = [input_limits;input_limits;input_limits];

state_dims = 18;
input_dims = 9;

A= [0,0,0,1,0,0;
    0,0,0,0,1,0;
    0,0,0,0,0,1;
    0,0,0,0,0,0;
    0,0,0,0,0,0;
    0,0,0,0,0,0];
A= blkdiag(A,A,A);

B= [0,0,0;
    0,0,0;
    0,0,0;
    1,0,0;
    0,1,0;
    0,0,1];
B = blkdiag(B,B,B);

c = zeros(state_dims,1);

R = eye(input_dims);

obstacles = [];%4,6,0,1,4,10;
             %4,0,0,1,4,10;
             %4,0,0,1,10,4;
             %4,0,6,1,10,4];
         
disp(['calculating closed form solution']);
rrt = rrtstar(A,B,c,R,[1:3,7:9,13:15]);
disp(['starting algorithm']);

dyn_obs_func = @(t) [];

state_free = @(state, time_range,base_time)(is_state_free(state, state_limits, obstacles, radius, time_range,dyn_obs_func,base_time));
input_free = @(input, time_range)(is_input_free(input, input_limits, time_range));
sample_state = @()(sample_free_states(sampling_limits,state_limits, obstacles, radius));
display = @(scratch, obj, tree, parents, goal, goal_cost, goal_parent)(plot_field(scratch, obj, tree, parents, obstacles, goal, goal_cost, goal_parent));

disp("Running")
[T, parents,iteration_times,iteration_costs] = rrt.run(sample_state, state_free, input_free, start', goal', display,500);

load trajectory.mat
delete trajectory.mat
save("times.mat",'iteration_times')
save("traj.mat",'full_path')
save("cost.mat",'iteration_costs')

