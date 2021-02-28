

world_limits = [...
    -1.5,1;
    -1.5,1;
     .5,2.5];
 
obs=[-.25,world_limits(2,1),world_limits(3,1),.125,world_limits(2,2)-world_limits(2,1),1.25-world_limits(3,1);
     -.25,world_limits(2,1),1.75,.125,world_limits(2,2)-world_limits(2,1),world_limits(3,2)-1.75;
     -.25,world_limits(2,1),1.25,.125,-1-world_limits(2,1),.5;
     -.25,-.5,1.25,.125,world_limits(2,2)+.5,.5];

start1 = [-1,-.5,1.5];
start2 = [-1,0,1.5];
start3 = [-1,.5,1.5];
stop1 = [.5,-.5,1.5];
stop2 = [.5,0,1.5];
stop3 = [.5,.5,1.5];