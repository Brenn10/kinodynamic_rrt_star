function [ scratch ] = plot_field(scratch, obj, tree, parents, obstacles, goal_state, goal_cost, goal_parent )
%PLOT_GRAPH Summary of this function goes here
%   Detailed explanation goes here
if ~isa(scratch,'struct') 
    %plot obstacles and waypoints    
    hold on;
    scratch = struct('figure_handle',gcf(),'last_parents', -1, 'trajectory_handles', -1, 'last_cost', inf, 'path_handles', []);
    for ii=1:size(obstacles,1)
        obs = obstacles(ii,:);   
        obs(1:3) = obs(1:3);
        
        a = obs(1:3);
        b = obs(1:3)+[obs(4),0,0];
        c = obs(1:3)+[obs(4),obs(5),0];
        d = obs(1:3)+[0,obs(5),0];
        e = obs(1:3)+[0,0,obs(6)];
        f = e+[obs(4),0,0];
        g = e+[obs(4),obs(5),0];
        h = e+[0,obs(5),0];
        
        plot_quad(a,b,c,d,'red'); %bottom
        plot_quad(e,f,g,h,'red'); %top
        plot_quad(a,b,f,e,'red'); %front
        plot_quad(d,c,g,h,'red'); %back
        plot_quad(a,d,h,e,'red'); %left
        plot_quad(b,c,g,f,'red'); %right
        
    end
        
end
start1 = [-1,-.5,1.5];
start2 = [-1,0,1.5];
start3 = [-1,.5,1.5];
plot_end(start1,'blue')
plot_end(start2,'green')
plot_end(start3,'cyan')

stop1 = [.5,-.5,1.5];
stop2 = [.5,0,1.5];
stop3 = [.5,.5,1.5];
plot_end(stop1,'blue')
plot_end(stop2,'green')
plot_end(stop3,'cyan')
axis equal
pause

%clf;
%hold on;
scratch.trajectory_handles = [scratch.trajectory_handles, -1];
scratch.last_parents = [scratch.last_parents, -1];
if false
    idx = find(scratch.last_parents~=parents);
    for ii=1:length(idx)
        
        changed_idx = idx(ii);
        src = tree(:,parents(changed_idx));
        dst = tree(:,changed_idx);
        draw_trajectory(obj, src, dst, 'cyan','magenta','yellow', 1, scratch.trajectory_handles(changed_idx));
    end
    scratch.last_parents = parents;
end

if goal_cost < scratch.last_cost

    for ii=1:length(scratch.path_handles)
       delete(scratch.path_handles(ii)); 
    end
    scratch.path_handles = [];
    p = goal_parent;
    [h1,h2,h3,path] = draw_trajectory(obj, tree(:,p), goal_state, 'green','red','blue', 3);
    full_path = path;
    scratch.path_handles = [scratch.path_handles,h1,h2,h3];
    uistack(h1, 'top')
    uistack(h2, 'top')
    uistack(h3, 'top')
    c = p;
    p = parents(c);
    while p > 0
        [h1,h2,h3, path] = draw_trajectory(obj, tree(:,p), tree(:,c), 'green','red','blue', 3);
        full_path(:,1) = full_path(:,1) + path(1,1);
        full_path = [full_path;path];
        scratch.path_handles = [scratch.path_handles,h1,h2,h3];
        uistack(h1, 'top')
        uistack(h2, 'top')
        uistack(h3, 'top')
        c = p;
        p = parents(c);
    end
    scratch.last_cost = goal_cost;
    save('trajectory.mat','full_path');
end

set(0, 'CurrentFigure', scratch.figure_handle);
xlabel('x');
ylabel('y');
zlabel('z');
title(['cost: ', num2str(goal_cost)]);
daspect([1 1 1]);
%hold off;
drawnow

end

function [] = plot_quad(a,b,c,d, color)    
    p = [a;b;c;d]; 
    fill3(p(:,1),p(:,2),p(:,3), zeros(4,1), 'FaceColor', [.8,.8,.8], 'EdgeColor', color);
end
function [] = plot_end(s, color)    
    
    width = .15;

    [X,Y,Z] = sphere;
    surf(X*width+s(1),Y*width+s(2),Z*width+s(3),'FaceColor',color,'EdgeColor',color)
end
function [h1,h2,h3,path] = draw_trajectory(obj,x0,x1,color1,color2,color3, thickness, old_handle)

    path = [];
    t = obj.evaluate_arrival_time(x0,x1);
    [states, ~] = obj.evaluate_states_and_inputs(x0,x1);
    X1 = [];
    Y1 = [];
    Z1 = [];
    X2 = [];
    Y2 = [];
    Z2 = [];
    X3 = [];
    Y3 = [];
    Z3 = [];
    ts = [t:-t/10:0];

    for jj=ts
        p = states(jj);
        X1 = [X1,p(1)];
        Y1 = [Y1,p(2)];
        Z1 = [Z1,p(3)];
        X2 = [X2,p(7)];
        Y2 = [Y2,p(8)];
        Z2 = [Z2,p(9)];
        X3 = [X3,p(13)];
        Y3 = [Y3,p(14)];
        Z3 = [Z3,p(15)];
        path = [path;jj,p.'];
    end

    if exist('old_handle','var') && old_handle ~= -1
        set(old_handle, 'XData', X1);
        set(old_handle, 'YData', Y1);
        set(old_handle, 'ZData', Z1);
        h1 = old_handle;
        h2 = old_handle;
    else
        h1 = line(X1, Y1, Z1, 'Color', color1, 'LineWidth', thickness);
        h2 = line(X2, Y2, Z2, 'Color', color2, 'LineWidth', thickness);
        h3 = line(X3, Y3, Z3, 'Color', color3, 'LineWidth', thickness);
    end
    
end