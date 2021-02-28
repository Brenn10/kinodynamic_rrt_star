function plot_costs_durs(setup)
    load(strcat(setup,"/simultaneous/cost.mat"))
    sim_costs = iteration_costs;
    load(strcat(setup,"/sequential/Drone1Costs.mat"))
    seq1_costs = iteration_costs;
    load(strcat(setup,"/sequential/Drone2Costs.mat"))
    seq2_costs = iteration_costs;

    load(strcat(setup,"/simultaneous/goal_times.mat"))
    sim_durs = iteration_goal_times;
    load(strcat(setup,"/sequential/RRT1goalTimes.mat"))
    seq1_durs = iteration_goal_times;
    load(strcat(setup,"/sequential/RRT2goalTimes.mat"))
    seq2_durs = iteration_goal_times;
    
    if(sim_costs(1,1)~=1)
        sim_costs = flip(sim_costs)
    end
    if(seq1_costs(1,1)~=1)
        seq1_costs = flip(seq1_costs)
    end
    if(seq2_costs(1,1)~=1)
        seq2_costs = flip(seq2_costs)
    end
    if(sim_durs(1,1)~=1)
        sim_durs = flip(sim_durs)
    end
    if(seq1_durs(1,1)~=1)
        seq1_durs = flip(seq1_durs)
    end
    if(seq2_durs(1,1)~=1)
        seq2_durs = flip(seq2_durs)
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
    plot(seq1_costs(:,2))
    hold on
    plot(seq2_costs(:,2))
    figure()
    
    seq_durs = [seq1_durs(:,1),max([seq1_durs(:,2),seq2_durs(:,2)],[],2)];
    seq_costs = zeros(size(seq1_durs));
    for i = 1 : size(seq1_durs,1)
        seq_costs(i,:) = [seq1_costs(i,1),seq1_costs(i,2)+seq2_costs(i,2)-seq_durs(i,2)];
    end
    
    
    subplot(2,1,1)
    plot(seq_durs(:,1),seq_durs(:,2));
    hold on;
    plot(sim_durs(:,1),sim_durs(:,2));
    title("Durations")
    legend(["Sequential" , "Simultaneous"])
    
    subplot(2,1,2)
    plot(seq_costs(:,1),seq_costs(:,2));
    hold on;
    plot(sim_costs(:,1),sim_costs(:,2));
    title("Costs")
    legend(["Sequential" , "Simultaneous"])
    
end

