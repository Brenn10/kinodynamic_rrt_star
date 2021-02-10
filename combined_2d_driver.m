clear figure
% in a 10x10x10 cube
start = [2,5,0,0];
start = [start,start]
goal  = [8,5,0,0];
goal = [goal,goal];

radius = .2;

state_limits = ...
    [0,10;
    0,10;
    -1,1;
    -1,1];
state_limits = [state_limits;state_limits];

sampling_limits = state_limits;

input_limits = ...
    [ -1,1;
      -1,1];
input_limits = [input_limits;input_limits];

state_dims = 8;
input_dims = 4;

A= [zeros(2),eye(2);zeros(2,4)];
A = blkdiag(A,A)

B= [zeros(2);eye(2)]
B = blkdiag(B,B);

c = zeros(state_dims,1);

R = eye(4)*1;

obstacles = [4.75,5.5,.5,4.5;
             4.75,0,.5,4.5];

disp(['calculating closed form solution']);
rrt = rrtstar(A,B,c,R,[1:2,5:6]);
disp(['starting algorithm']);

state_free = @(state, time_range)(combined_2d_is_state_free(state, state_limits, obstacles, radius, time_range));
input_free = @(input, time_range)(is_input_free(input, input_limits, time_range));
sample_state = @()(combined_2d_sample_free_states(sampling_limits,state_limits, obstacles, radius));
display = @(scratch, obj, tree, parents, goal, goal_cost, goal_parent)(combined_2d_plot_field(scratch, obj, tree, parents, obstacles, goal, goal_cost, goal_parent));

disp("Running")
[T, parents] = rrt.run(sample_state, state_free, input_free, start', goal', display);
