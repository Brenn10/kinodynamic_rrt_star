do_no_obstacle = true;
do_obstacle_course = true;
do_window_2 = true;
do_window_3 = true;

line_width = 3;
font_size = 16;

%% no_obstacle
if do_no_obstacle
    setup = "no_obstacle";
    load(strcat(setup,"/simultaneous/times.mat"))
    sim_times = iteration_times;
    load(strcat(setup,"/sequential/RRT2times.mat"))
    seq_times2 = iteration_times;

    figure()
    plot(seq_times2(:,1),seq_times2(:,2)-min(seq_times2(:,2)),sim_times(:,1),sim_times(:,2)-min(sim_times(:,2)),'LineWidth', line_width)
    legend([ "Sequential","Simultaneous"])
    %title("No Obstacles")
    xlabel("Iterations")
    ylabel("Time (cpu ticks)")
     legend('Location','northwest')
    set(gca,'FontSize', font_size);
    saveas(gcf,strcat(setup,'_times.png'))
end

%% obstacle_course
if do_obstacle_course
    setup = "obstacle_course";
    load(strcat(setup,"/simultaneous/times.mat"))
    sim_times = iteration_times;
    load(strcat(setup,"/sequential/RRT1times.mat"))
    seq_times1 = iteration_times;
    load(strcat(setup,"/sequential/RRT2times.mat"))
    seq_times2 = iteration_times;
    sum_times = seq_times2(:,2)+seq_times1(:,2);

    figure()
    plot(seq_times2(:,1),sum_times-min(sum_times),sim_times(:,1),sim_times(:,2)-min(sim_times(:,2)),'LineWidth', line_width)
%     legend(["Sequential","Simultaneous"])
    %title("Obstacle Course")
    xlabel("Iterations")
    ylabel("Time (cpu ticks)")
%     legend('Location','northwest')
    set(gca,'FontSize', font_size);
    saveas(gcf,strcat(setup,'_times.png'))
end

%% window_2
if do_window_2
    setup = "window";
    load(strcat(setup,"/simultaneous/times.mat"))
    sim_times = iteration_times;
    load(strcat(setup,"/sequential/RRT1times.mat"))
    seq_times1 = iteration_times;
    load(strcat(setup,"/sequential/RRT2times.mat"))
    seq_times2 = iteration_times;
    sum_times = seq_times2(:,2)+seq_times1(:,2);
    figure()
    plot(seq_times2(:,1),sum_times-min(sum_times),sim_times(:,1),sim_times(:,2)-min(sim_times(:,2)),'LineWidth', line_width)
%     legend(["Sequential","Simultaneous"])
    %title("Window 2")
    xlabel("Iterations")
    ylabel("Time (cpu ticks)")
%     legend('Location','northwest')
    set(gca,'FontSize', font_size);
    saveas(gcf,strcat(setup,'_times.png'))
end

%% window_3
if do_window_3
    setup = "window_3";
    load(strcat(setup,"/simultaneous/times.mat"))
    sim_times = iteration_times;
    load(strcat(setup,"/sequential/RRT1times.mat"))
    seq_times1 = iteration_times;
    load(strcat(setup,"/sequential/RRT2times.mat"))
    seq_times2 = iteration_times;
    load(strcat(setup,"/sequential/RRT3times.mat"))
    seq_times3 = iteration_times;
    sum_times = seq_times3(:,2)+seq_times2(:,2)+seq_times1(:,2);

    figure()
    plot(seq_times2(:,1),sum_times-min(sum_times),sim_times(:,1),sim_times(:,2)-min(sim_times(:,2)),'LineWidth', line_width)
%     legend([ "Sequential","Simultaneous"])
    %title("Window 3")
    xlabel("Iterations")
    ylabel("Time (cpu ticks)")
%     legend('Location','northwest')
    set(gca,'FontSize', font_size);
    saveas(gcf,strcat(setup,'_times.png'))
end