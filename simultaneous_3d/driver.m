clc
clear all
% in a 10x10x10 cube
start = [1,5,5,0,0,0,9,5,5,0,0,0];
goal  = [9,5,5,0,0,0,1,5,5,0,0,0];

radius = .2;

state_limits = ...
    [0,10;
    0,10;
    0,10;
    -1,1;
    -1,1;
    -1,1];
state_limits = [state_limits;state_limits];

sampling_limits = state_limits;

input_limits = ...
    [ -1,1;
      -1,1;
      -1,1];
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
B = blkdiag(B,B)

c = zeros(state_dims,1);

R = eye(input_dims);

obstacles = []%4,6,0,1,4,10;
             %4,0,0,1,4,10;
             %4,0,0,1,10,4;
             %4,0,6,1,10,4];
         
disp(['calculating closed form solution']);
rrt = rrtstar(A,B,c,R,[1:3,7:9]);
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

