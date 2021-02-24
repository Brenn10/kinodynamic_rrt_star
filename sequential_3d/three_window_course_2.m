world_limits = [...
    -1,1;
    -1,1;
    0,2];
 
obs=[]

table =[...
    -.55,.05;
    world_limits(2,1),world_limits(2,2);
    0,.86]

window1 = [...
    -.05,.05;
    -.45,.24;
    .86,1.27];

window2 =[...
    .06,.5;
    -.31,.18;
    .8,.84];

window3 =[...
    .07,.48;
    .21,.30;
    .02,.71];

obs = [...
    obs;
    world_limits(1,1),table(2,1),table(3,1),table(1,2)-world_limits(1,1),table(2,2)-table(2,1),table(3,2)-table(3,1)];

obs = [...
    obs;
    window1(1,1),world_limits(2,1),table(3,2),window1(1,2)-window1(1,1),window1(2,1)-world_limits(2,1),world_limits(3,2)-table(3,2);
    window1(1,1),window1(2,1),window1(3,2),window1(1,2)-window1(1,1),world_limits(2,2)-window1(2,1),world_limits(3,2)-window1(3,2);
    window1(1,1),window1(2,2),table(3,2),window1(1,2)-window1(1,1),world_limits(2,2)-window1(2,2),window1(3,2)-window1(3,1);
    ];

obs = [...
    obs;
    window1(1,2),world_limits(2,1),world_limits(3,1),world_limits(1,2)-window1(1,2),window2(2,1)-world_limits(2,1),window2(3,2)-world_limits(3,1);
    window1(1,2),window2(2,1),world_limits(3,1),window2(1,1)-window1(1,2),window2(2,2)-window2(2,1),window2(3,2)-world_limits(3,1);
    window2(1,2),window2(2,1),window2(3,1),world_limits(1,2)-window2(1,2),window2(2,2)-window2(2,1),window2(3,2)-window2(3,1);
    window1(1,2),window2(2,2),window2(3,1),world_limits(1,2)-window1(1,2),window3(2,1)-window2(2,2),window2(3,2)-window2(3,1);
    ];

obs = [...
    obs;
    window1(1,2),window3(2,1),world_limits(3,1),window3(1,1)-window1(1,2),window3(2,2)-window3(2,1),world_limits(3,2)-world_limits(3,1);
    window2(1,1),window3(2,1),window3(3,2),world_limits(1,2)-window2(1,1),window3(2,2)-window3(2,1),world_limits(3,2)-window3(3,2);
    window3(1,2),window3(2,1),world_limits(3,1),world_limits(1,2)-window3(1,2),window3(2,2)-window3(2,1),window3(3,2)-world_limits(3,1);
    
    ];

start = [-.5,-.5,1.5];
stop = [.25,.75,1.5];
    