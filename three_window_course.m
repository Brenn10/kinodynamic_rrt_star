world_limits = [...
    -2,1;
    -3,2;
     0,3];
 
obs=[]

table =[...
    -.82,-2.45,0;
    -.24,-1.32, .86]

obs = [...
    obs;
    table(1,:),table(2,:)-table(1,:)];

window1 = [...
    -.24,-2.14,.87;
    -.28,-1.48,1.29];
obs = [...
    obs;
    window1(1,1),world_limits(2,1),world_limits(3,1),window1(2,1)-window1(1,1),window1(1,2)-world_limits(2,1),world_limits(3,2)-world_limits(3,1); %right as drone passes
    window1(1,1),window1(2,2),world_limits(3,1),window1(2,1)-window1(1,1),world_limits(2,2)-window1(2,2),world_limits(3,2)-world_limits(3,1); % left as drone passes
    window1(1,1),window1(1,2),world_limits(3,1),window1(2,1)-window1(1,1),window1(2,2)-window1(1,2),window1(1,3)-world_limits(3,1); % below as drone passes
    window1(1,1),window1(1,2),window1(2,3),window1(2,1)-window1(1,1),window1(2,2)-window1(1,2),world_limits(3,2)-window1(2,3)]; % above as drone passes

window2 = [...
    .36,-.48,.02;
    .78,-.44,.74];
obs = [...
    obs;
    world_limits(1,1),window2(1,2),world_limits(3,1),window2(1,1)-world_limits(1,1),window2(2,2)-window2(1,2),world_limits(3,2)-world_limits(3,1); % left as drone passes
    window2(2,1),window2(1,2),world_limits(3,1),world_limits(1,2)-window2(2,1),window2(2,2)-window2(1,2),world_limits(3,2)-world_limits(3,1); % right as drone passes
    window2(1,1),window2(1,2),world_limits(3,1),window2(2,1)-window2(1,1),window2(2,2)-window2(1,2),window2(1,3)-world_limits(3,1); % below as drone passes
    window2(1,1),window2(1,2),window2(2,3),window2(2,1)-window2(1,1),window2(2,2)-window2(1,2),world_limits(3,2)-window2(2,3); % above as drone passes
    ];

window3 = [...
    .38,.25,1.47;
    .81,.7,1.57];

obs = [...
    obs;
    world_limits(1,1),window3(1,2),window3(1,3),window3(1,1)-world_limits(1,1),world_limits(2,2)-window3(1,2),window3(2,3)-window3(1,3); % left as drone passes
    window3(2,1),window3(1,2),window3(1,3),world_limits(1,2)-window3(2,1),world_limits(2,2)-window3(1,2),window3(2,3)-window3(1,3); % right as drone passes
    world_limits(1,1),window3(2,2),world_limits(3,1),world_limits(1,2)-world_limits(1,1),world_limits(2,2)-window3(2,2),window3(2,3)-world_limits(3,1);
    world_limits(1,1),window2(2,2),window3(1,3),world_limits(1,2)-world_limits(1,1),window3(1,2)-window2(2,2),window3(2,3)-window3(1,3);
    ];


start = [-1.5,-2,1.9];
stop = [.5,1.5,2];
    