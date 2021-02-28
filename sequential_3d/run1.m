clc
clear all

three_window_course_2

start1 = [start,0,0,0];
goal1  = [stop,0,0,0];

setup
         
disp(['calculating closed form solution']);
rrt = rrtstar(A,B,c,R,1:3,1);
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

