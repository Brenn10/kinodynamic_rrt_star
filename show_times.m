load Drone1Costs.mat
d1times = iteration_costs
load Drone2Costs.mat
d2times = iteration_costs

plot(d1times(:,1),d1times(:,2))
hold on;
plot(d2times(:,1),d2times(:,2))
legend(["Drone 1", "Drone 2"])