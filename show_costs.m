load RRT1times.mat
d1times = iteration_times
d1times(:,2) = d1times(:,2)-d1times(end,2)
load RRT2times.mat
d2times = iteration_times
d2times(:,2) = d2times(:,2)-d2times(end,2)

plot(d1times(:,1),d1times(:,2))
hold on;
plot(d2times(:,1),d2times(:,2))
legend(["Drone 1", "Drone 2"])