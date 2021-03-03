clear all
clc
do_obstacle_course = true;
do_no_obstacles = true;
do_no_obstacles_2 = false;
do_window_2 = true;
do_window_3 = true;

%% no_obstacle_2
if do_no_obstacles_2
    setup = "no_obstacle_2d";
%     load(strcat(setup,"/simultaneous/cost.mat"))
%     sim_costs = iteration_costs;
    load(strcat(setup,"/sequential/Drone1Costs.mat"))
    seq1_cost = iteration_costs
    load(strcat(setup,"/sequential/Drone2Costs.mat"))
    seq2_costs = iteration_costs;

%     load(strcat(setup,"/simultaneous/goal_times.mat"))
%     sim_durs = iteration_goal_times;
%     sim_durs(:,2) = [sim_durs(2:end,2);nan];
    load(strcat(setup,"/sequential/RRT1goaltimes.mat"))
    seq1_dur = iteration_goal_times;
    load(strcat(setup,"/sequential/RRT2goaltimes.mat"))
    seq2_durs = iteration_goal_times;
    seq2_durs(:,2) = [seq2_durs(2:end,2);nan];

%     if(sim_costs(1,1)~=1)
%         sim_costs = flip(sim_costs);
%     end
    if(seq2_costs(1,1)~=1)
        seq2_costs = flip(seq2_costs);
    end
%     if(sim_durs(1,1)~=1)
%         sim_durs = flip(sim_durs);
%     end
    if(seq2_durs(1,1)~=1)
        seq2_durs = flip(seq2_durs);
    end

    seq2_durs(isinf(seq2_durs(:,2)),2)=nan;
%     sim_durs(isinf(sim_durs(:,2)),2)=nan;
    seq2_costs(isinf(seq2_costs(:,2)),2)=nan;
%     sim_costs(isinf(sim_costs(:,2)),2)=nan;
    seq2_durs = fillmissing(seq2_durs,'previous',1);
%     sim_durs = fillmissing(sim_durs,'previous',1);
    seq2_costs = fillmissing(seq2_costs,'previous',1);
%     sim_costs = fillmissing(sim_costs,'previous',1);
% 
%      figure()
%      plot(seq2_durs(:,2))
%      hold on
%      plot(seq2_costs(:,2))
%      legend(["Durs", "costs"])
     
    figure()

    min_durs = min([seq1_dur*ones(size(seq2_durs,1)),seq2_durs(:,2)],[],2);
    seq_costs = [seq2_costs(:,1),seq1_cost+seq2_costs(:,2)-min_durs(:)];



%     subplot(2,1,1)
%     plot(seq_durs(:,1),seq_durs(:,2));
%     hold on;
%     plot(sim_durs(:,1),sim_durs(:,2));
%     %title("Durations")
%     legend(["Sequential" , "Simultaneous"])

%     subplot(2,1,2)
    plot(seq_costs(:,1),seq_costs(:,2));
    hold on;
%     plot(sim_costs(:,1),sim_costs(:,2));
    %title("No Obstacle Costs")
%     legend(["Sequential" , "Simultaneous"])
    xlabel("Iterations")
    ylabel("Cost")
    saveas(gcf,strcat(setup,'_cost.png'))
end

%% no_obstacle
if do_no_obstacles
    setup = "no_obstacle";
    load(strcat(setup,"/simultaneous/cost.mat"))
    sim_costs = iteration_costs;
    load(strcat(setup,"/sequential/Drone2Costs.mat"))
    seq2_costs = iteration_costs;

    load(strcat(setup,"/simultaneous/goal_times.mat"))
    sim_durs = iteration_goal_times;
    sim_durs(:,2) = [sim_durs(2:end,2);nan];
    load(strcat(setup,"/sequential/RRT2goalTimes.mat"))
    seq2_durs = iteration_goal_times;
    seq2_durs(:,2) = [seq2_durs(2:end,2);nan];

    if(sim_costs(1,1)~=1)
        sim_costs = flip(sim_costs);
    end
    if(seq2_costs(1,1)~=1)
        seq2_costs = flip(seq2_costs);
    end
    if(sim_durs(1,1)~=1)
        sim_durs = flip(sim_durs);
    end
    if(seq2_durs(1,1)~=1)
        seq2_durs = flip(seq2_durs);
    end

    seq1_cost = 6.3000;
    seq1_dur = ones(size(seq2_costs,1))*3;

    seq2_durs(isinf(seq2_durs(:,2)),2)=nan;
    sim_durs(isinf(sim_durs(:,2)),2)=nan;
    seq2_costs(isinf(seq2_costs(:,2)),2)=nan;
    sim_costs(isinf(sim_costs(:,2)),2)=nan;
    seq2_durs = fillmissing(seq2_durs,'previous',1);
    sim_durs = fillmissing(sim_durs,'previous',1);
    seq2_costs = fillmissing(seq2_costs,'previous',1);
    sim_costs = fillmissing(sim_costs,'previous',1);
% 
%      figure()
%      plot(seq2_durs(:,2))
%      hold on
%      plot(seq2_costs(:,2))
%      legend(["Durs", "costs"])
     
    figure()

    min_durs = min([seq1_dur,seq2_durs(:,2)],[],2);
    seq_costs = [seq2_costs(:,1),seq1_cost+seq2_costs(:,2)-min_durs(:)];



%     subplot(2,1,1)
%     plot(seq_durs(:,1),seq_durs(:,2));
%     hold on;
%     plot(sim_durs(:,1),sim_durs(:,2));
%     %title("Durations")
%     legend(["Sequential" , "Simultaneous"])

%     subplot(2,1,2)
    plot(seq_costs(:,1),seq_costs(:,2),'LineWidth',2);
    hold on;
    plot(sim_costs(:,1),sim_costs(:,2),'LineWidth',2);
    %title("No Obstacle Costs")
    legend(["Sequential" , "Simultaneous"])
    xlabel("Iterations")
    ylabel("Cost")
    saveas(gcf,strcat(setup,'_cost.png'))
end

%% obstacle_course
if do_obstacle_course
    setup = "obstacle_course";
    load(strcat(setup,"/simultaneous/cost.mat"))
    sim_costs = iteration_costs;
    load(strcat(setup,"/sequential/Drone1Costs.mat"))
    seq1_costs = iteration_costs;
    load(strcat(setup,"/sequential/Drone2Costs.mat"))
    seq2_costs = iteration_costs;

    load(strcat(setup,"/simultaneous/goal_times.mat"))
    sim_durs = iteration_goal_times;
    sim_durs(:,2) = [sim_durs(2:end,2);nan];
    load(strcat(setup,"/sequential/RRT1goalTimes.mat"))
    seq1_durs = iteration_goal_times;
    seq1_durs(:,2) = [seq1_durs(2:end,2);nan];
    load(strcat(setup,"/sequential/RRT2goalTimes.mat"))
    seq2_durs = iteration_goal_times;
    seq2_durs(:,2) = [seq2_durs(2:end,2);nan];

    if(sim_costs(1,1)~=1)
        sim_costs = flip(sim_costs);
    end
    if(seq1_costs(1,1)~=1)
        seq1_costs = flip(seq1_costs);
    end
    if(seq2_costs(1,1)~=1)
        seq2_costs = flip(seq2_costs);
    end
    if(sim_durs(1,1)~=1)
        sim_durs = flip(sim_durs);
    end
    if(seq1_durs(1,1)~=1)
        seq1_durs = flip(seq1_durs);
    end
    if(seq2_durs(1,1)~=1)
        seq2_durs = flip(seq2_durs);
    end


    seq1_durs(isinf(seq1_durs(:,2)),2)=nan;
    seq2_durs(isinf(seq2_durs(:,2)),2)=nan;
    sim_durs(isinf(sim_durs(:,2)),2)=nan;
    seq1_costs(isinf(seq1_costs(:,2)),2)=nan;
    seq2_costs(isinf(seq2_costs(:,2)),2)=nan;
    sim_costs(isinf(sim_costs(:,2)),2)=nan;
    seq1_durs = fillmissing(seq1_durs,'previous',1);
    seq2_durs = fillmissing(seq2_durs,'previous',1);
    sim_durs = fillmissing(sim_durs,'previous',1);
    seq1_costs = fillmissing(seq1_costs,'previous',1);
    seq2_costs = fillmissing(seq2_costs,'previous',1);
    sim_costs = fillmissing(sim_costs,'previous',1);

    figure()
    clf

    min_durs = min([seq1_durs(:,2),seq2_durs(:,2)],[],2);
    seq_costs = [seq1_costs(:,1),seq1_costs(:,2)+seq2_costs(:,2)-min_durs(:)];

    plot(seq_costs(:,1),seq_costs(:,2),'LineWidth',2);
    hold on;
    plot(sim_costs(:,1),sim_costs(:,2),'LineWidth',2);
    %title("Costs")
    lgd = legend(["Sequential" , "Simultaneous"])
    %title("Obstacle Course Costs")
    xlabel("Iterations")
    ylabel("Cost")
    set(gca,'FontSize', 12);
    saveas(gcf,strcat(setup,'_cost.png'))
end

%% window_2
if do_window_2
    setup = "window";
    load(strcat(setup,"/simultaneous/cost.mat"))
    sim_costs = iteration_costs;
    load(strcat(setup,"/sequential/Drone1Costs.mat"))
    seq1_costs = iteration_costs;
    load(strcat(setup,"/sequential/Drone2Costs.mat"))
    seq2_costs = iteration_costs;

    load(strcat(setup,"/simultaneous/goal_times.mat"))
    sim_durs = iteration_goal_times;
    sim_durs(:,2) = [sim_durs(2:end,2);nan];
    load(strcat(setup,"/sequential/RRT1goalTimes.mat"))
    seq1_durs = iteration_goal_times;
    seq1_durs(:,2) = [seq1_durs(2:end,2);nan];
    load(strcat(setup,"/sequential/RRT2goalTimes.mat"))
    seq2_durs = iteration_goal_times;
    seq2_durs(:,2) = [seq2_durs(2:end,2);nan];

    if(sim_costs(1,1)~=1)
        sim_costs = flip(sim_costs);
    end
    if(seq1_costs(1,1)~=1)
        seq1_costs = flip(seq1_costs);
    end
    if(seq2_costs(1,1)~=1)
        seq2_costs = flip(seq2_costs);
    end
    if(sim_durs(1,1)~=1)
        sim_durs = flip(sim_durs);
    end
    if(seq1_durs(1,1)~=1)
        seq1_durs = flip(seq1_durs);
    end
    if(seq2_durs(1,1)~=1)
        seq2_durs = flip(seq2_durs);
    end


    seq1_durs(isinf(seq1_durs(:,2)),2)=nan;
    seq2_durs(isinf(seq2_durs(:,2)),2)=nan;
    sim_durs(isinf(sim_durs(:,2)),2)=nan;
    seq1_costs(isinf(seq1_costs(:,2)),2)=nan;
    seq2_costs(isinf(seq2_costs(:,2)),2)=nan;
    sim_costs(isinf(sim_costs(:,2)),2)=nan;
    seq1_durs = fillmissing(seq1_durs,'previous',1);
    seq2_durs = fillmissing(seq2_durs,'previous',1);
    sim_durs = fillmissing(sim_durs,'previous',1);
    seq1_costs = fillmissing(seq1_costs,'previous',1);
    seq2_costs = fillmissing(seq2_costs,'previous',1);
    sim_costs = fillmissing(sim_costs,'previous',1);

    figure()
    clf

    min_durs = min([seq1_durs(:,2),seq2_durs(:,2)],[],2);
    seq_costs = [seq1_costs(:,1),seq1_costs(:,2)+seq2_costs(:,2)-min_durs(:)];

%     subplot(2,1,1)
%     plot(seq_durs(:,1),seq_durs(:,2));
%     hold on;
%     plot(sim_durs(:,1),sim_durs(:,2));
%     %title("Durations")
%     legend(["Sequential" , "Simultaneous"])
% 
%     subplot(2,1,2)

    plot(seq_costs(:,1),seq_costs(:,2),'LineWidth',2);
    hold on;
    plot(sim_costs(:,1),sim_costs(:,2),'LineWidth',2);
    legend(["Sequential" , "Simultaneous"])
    %title("Window 2 Costs")
    xlabel("Iterations")
    ylabel("Cost")
    set(gca,'FontSize', 12);
    saveas(gcf,strcat(setup,'_cost.png'))
end

%% window3
if do_window_3
    setup = "window_3";
    load(strcat(setup,"/simultaneous/cost.mat"))
    sim_costs = iteration_costs;
    load(strcat(setup,"/sequential/Drone1Costs.mat"))
    seq1_costs = iteration_costs;
    load(strcat(setup,"/sequential/Drone2Costs.mat"))
    seq2_costs = iteration_costs;
    load(strcat(setup,"/sequential/Drone3Costs.mat"))
    seq3_costs = iteration_costs;

    %load(strcat(setup,"/simultaneous/goal_times.mat"))
    %sim_durs = iteration_goal_times;
    load(strcat(setup,"/sequential/RRT1goalTimes.mat"))
    seq1_durs = iteration_goal_times;
    seq1_durs(:,2) = [seq1_durs(2:end,2);nan];
    load(strcat(setup,"/sequential/RRT2goalTimes.mat"))
    seq2_durs = iteration_goal_times;
    seq2_durs(:,2) = [seq2_durs(2:end,2);nan];
    load(strcat(setup,"/sequential/RRT3goalTimes.mat"))
    seq3_durs = iteration_goal_times;
    seq3_durs(:,2) = [seq3_durs(2:end,2);nan];

    if(sim_costs(1,1)~=1)
        sim_costs = flip(sim_costs);
    end
    if(seq1_costs(1,1)~=1)
        seq1_costs = flip(seq1_costs);
    end
    if(seq2_costs(1,1)~=1)
        seq2_costs = flip(seq2_costs);
    end
    if(seq3_costs(1,1)~=1)
        seq3_costs = flip(seq3_costs);
    end

    if(seq1_durs(1,1)~=1)
        seq1_durs = flip(seq1_durs);
    end
    if(seq2_durs(1,1)~=1)
        seq2_durs = flip(seq2_durs);
    end
    if(seq3_durs(1,1)~=1)
        seq3_durs = flip(seq3_durs);
    end
    


    seq1_durs(isinf(seq1_durs(:,2)),2)=nan;
    seq2_durs(isinf(seq2_durs(:,2)),2)=nan;
    seq3_durs(isinf(seq3_durs(:,2)),2)=nan;
%     sim_durs(isinf(sim_durs(:,2)),2)=nan;
    seq1_costs(isinf(seq1_costs(:,2)),2)=nan;
    seq2_costs(isinf(seq2_costs(:,2)),2)=nan;
    seq3_costs(isinf(seq3_costs(:,2)),2)=nan;
    sim_costs(isinf(sim_costs(:,2)),2)=nan;
    seq1_durs = fillmissing(seq1_durs,'previous',1);
    seq2_durs = fillmissing(seq2_durs,'previous',1);
    seq3_durs = fillmissing(seq3_durs,'previous',1);
%     sim_durs = fillmissing(sim_durs,'previous',1);
    seq1_costs(:,2) = cummin(fillmissing(seq1_costs(:,2),'previous',1));
    seq2_costs(:,2) = cummin(fillmissing(seq2_costs(:,2),'previous',1));
    seq3_costs(:,2) = cummin(fillmissing(seq3_costs(:,2),'previous',1));
    sim_costs(:,2) = cummin(fillmissing(sim_costs(:,2),'previous',1));



    seq1_raw_costs = seq1_costs(:,2)-seq1_durs(:,2);
    seq2_raw_costs = seq2_costs(:,2)-seq2_durs(:,2);
    seq3_raw_costs = seq3_costs(:,2)-seq3_durs(:,2);
    max_durs = max([seq1_durs(:,2),seq2_durs(:,2),seq3_durs(:,2)],[],2);
    seq_costs = [seq1_costs(:,1),seq1_raw_costs+seq2_raw_costs+seq3_raw_costs+max_durs];

   
    figure()
    plot(seq_costs(:,1),seq_costs(:,2),'LineWidth',2);
    hold on;
    plot(sim_costs(:,1),sim_costs(:,2),'LineWidth',2);
    %title("Costs")
    legend(["Sequential" , "Simultaneous"])
    legend('Location','northwest')
    %title("Window 3 Costs")
    xlabel("Iterations")
    ylabel("Cost")
    set(gca,'FontSize', 12);
    saveas(gcf,strcat(setup,'_cost.png'))
end