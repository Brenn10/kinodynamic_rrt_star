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