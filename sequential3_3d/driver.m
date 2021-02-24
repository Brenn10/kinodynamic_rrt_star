clc
clear all
% in a 10x10x10 cube

three_window_course_3

% drone 1 start

start1 = [start1,0,0,0];
goal1  = [stop1,0,0,0];
start2 = [start2,0,0,0];
goal2 = [stop2 ,0,0,0];
start3 = [start3,0,0,0];
goal3 = [stop3,0,0,0];

radius = .15;

state_limits = ...
    [world_limits;
    -1,1;
    -1,1;
    -1,1];

sampling_limits = state_limits;

input_limits = ...
    [ -.9,.9;
      -.9,.9;
      -.7,.7];

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

obstacles = obs;
iterations = 10000;
         
disp(['calculating closed form solution']);
rrt = rrtstar(A,B,c,R,1:3);
disp(['starting algorithm']);

dyn_obs_func = @(t) [];
state_free = @(state, time_range,base_time)(is_state_free(state, state_limits, obstacles, radius, time_range,dyn_obs_func,base_time));
input_free = @(input, time_range)(is_input_free(input, input_limits, time_range));
sample_state = @()(sample_free_states(sampling_limits,state_limits, obstacles, radius));
display = @(scratch, obj, tree, parents, goal, goal_cost, goal_parent)(plot_field(scratch, obj, tree, parents, obstacles, goal, goal_cost, goal_parent));
disp("Running")
[T, parents,iteration_times,iteration_costs] = rrt.run(sample_state, state_free, input_free, start1', goal1', display,iterations);
load trajectory.mat
save("RRT1times.mat",'iteration_times')
save("Drone1Traj.mat",'full_path')
save("Drone1Costs.mat",'iteration_costs')

dyn_obs1 = [full_path(:,1:4),ones(size(full_path,1),3)*radius];
dyn_obs_func = @(t) dynamic_obs(t,dyn_obs1,[]);
state_free = @(state, time_range,base_time)(is_state_free(state, state_limits, obstacles, radius, time_range,dyn_obs_func,base_time));
input_free = @(input, time_range)(is_input_free(input, input_limits, time_range));
sample_state = @()(sample_free_states(sampling_limits,state_limits, obstacles, radius));
display = @(scratch, obj, tree, parents, goal, goal_cost, goal_parent)(plot_field(scratch, obj, tree, parents, obstacles, goal, goal_cost, goal_parent));
disp("Running")
[T, parents,iteration_times,iteration_costs] = rrt.run(sample_state, state_free, input_free, start2', goal2', display,iterations);
load trajectory.mat
save("RRT2times.mat",'iteration_times')
save("Drone2Traj.mat",'full_path')
save("Drone2Costs.mat",'iteration_costs')

dyn_obs2 = [full_path(:,1:4),ones(size(full_path,1),3)*radius];
dyn_obs_func = @(t) dynamic_obs(t,dyn_obs1,dyn_obs2);
state_free = @(state, time_range,base_time)(is_state_free(state, state_limits, obstacles, radius, time_range,dyn_obs_func,base_time));
input_free = @(input, time_range)(is_input_free(input, input_limits, time_range));
sample_state = @()(sample_free_states(sampling_limits,state_limits, obstacles, radius));
display = @(scratch, obj, tree, parents, goal, goal_cost, goal_parent)(plot_field(scratch, obj, tree, parents, obstacles, goal, goal_cost, goal_parent));
disp("Running")
[T, parents,iteration_times,iteration_costs] = rrt.run(sample_state, state_free, input_free, start3', goal3', display,iterations);
load trajectory.mat
save("RRT3times.mat",'iteration_times')
save("Drone3Traj.mat",'full_path')
save("Drone3Costs.mat",'iteration_costs')
