clc
clear all
% in a 10x10x10 cube

three_window_course_3

% drone 1 start
start3 = [start3,0,0,0];
goal3 = [stop3 ,0,0,0];

setup
         
disp(['calculating closed form solution']);
rrt = rrtstar(A,B,c,R,1:3,.9^2);
disp(['starting algorithm']);

load Drone1Traj.mat
dyn_obs1 = [full_path(:,1),full_path(:,2:4)-ones(size(full_path,1),3)*radius,ones(size(full_path,1),3)*radius*2];
load Drone2Traj.mat
dyn_obs2 = [full_path(:,1),full_path(:,2:4)-ones(size(full_path,1),3)*radius,ones(size(full_path,1),3)*radius*2];
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
