clear figure
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

state_free = @(state, time_range)(single_is_state_free(state, state_limits, obstacles, radius, time_range));
input_free = @(input, time_range)(is_input_free(input, input_limits, time_range));
sample_state = @()(single_sample_free_states(sampling_limits,state_limits, obstacles, radius));
display = @(scratch, obj, tree, parents, goal, goal_cost, goal_parent)(single_plot_field(scratch, obj, tree, parents, obstacles, goal, goal_cost, goal_parent));

disp("Running")
[T, parents] = rrt.run(sample_state, state_free, input_free, start', goal', display);
