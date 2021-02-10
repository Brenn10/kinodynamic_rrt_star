function [ scratch ] = combined_2d_plot_field(scratch, obj, tree, parents, obstacles, goal_state, goal_cost, goal_parent )
%PLOT_GRAPH Summary of this function goes here
%   Detailed explanation goes here

clf;
hold on;
if false
    for ii=2:size(tree,2) %root node has no parents -> start with 2
        src = tree(:,parents(ii));
        dst = tree(:,ii);
        draw_trajectory(obj, src, dst, 'blue','red', 1);
    end
end


for ii=1:size(obstacles,1)
    obs = obstacles(ii,:);
    line([obs(1),        obs(1)+obs(3)], [obs(2),        obs(2)],         'Color','red');
    line([obs(1)+obs(3), obs(1)+obs(3)], [obs(2),        obs(2)+obs(4)],  'Color','red');
    line([obs(1)+obs(3), obs(1)],        [obs(2)+obs(4), obs(2)+obs(4)],  'Color','red');
    line([obs(1),        obs(1)],        [obs(2)+obs(4), obs(2)],         'Color','red');
end

if goal_cost < inf
    p = goal_parent;
    [h1,h2] = draw_trajectory(obj, tree(:,p), goal_state, 'green','red', 3);
    uistack(h1, 'top')
    uistack(h2, 'top')
    c = p;
    p = parents(c);
    while p > 0
        [h1,h2] = draw_trajectory(obj, tree(:,p), tree(:,c), 'green','red', 3);
        uistack(h1, 'top')
        uistack(h2, 'top')
        c = p;
        p = parents(c);
    end
end

hold off;
title(['cost: ', num2str(goal_cost)]);
drawnow

end

function [h1,h2] = draw_trajectory(obj,x0,x1,color1,color2, thickness)

    t = obj.evaluate_arrival_time(x0,x1);
    [states, ~] = obj.evaluate_states_and_inputs(x0,x1);
    X1 = [];
    Y1 = [];   
    X2 = [];
    Y2 = [];
    for jj=[0:1:t,t]
        p = states(jj);
        X1 = [X1,p(1)];
        Y1 = [Y1,p(2)];
        X2 = [X2,p(5)];
        Y2 = [Y2,p(6)];
    end
    h1 = line(X1, Y1, 'Color', color1, 'LineWidth', thickness);
    h2 = line(X2, Y2, 'Color', color2, 'LineWidth', thickness);

end
