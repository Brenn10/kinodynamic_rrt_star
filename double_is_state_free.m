function [ ok ] = double_is_state_free( state, state_limits, obstacles, radius, time_range,dynamic_obstacles,base_time)
%IS_STATE_FREE returns true if the given state is valid
% - state is the 10 dimensional state vector
% - state_limits limits for the state variables
% - obstacles is an n by 6 matrix where each row contains one corner and
% the distance to the other
% - quad_dim contains the size of the quadcopter bounding-box

ok = true;
max_dist = .1;

if isa(state,'sym')

    %dt = time_range(2)-time_range(1);
    r = [time_range(1):max_dist:time_range(2)];

    s = eval(subs(state,r));

    for ii=1:size(state_limits, 1)
        dyn_obs = dynamic_obstacles(r(ii)+base_time);
        
        curr_obstacles =[ obstacles;  dyn_obs];
        if sum(s(ii,:)<state_limits(ii, 1)) > 0 || sum(s(ii,:)>state_limits(ii, 2)) > 0
        %if ~isAlways(state(ii) >= state_limits(ii, 1)) || ~isAlways(state(ii) <= state_limits(ii, 2))
            ok = false;
            return;
        end
        if collides(curr_obstacles, radius, s)
            ok = false;
            return;
        end
    end
elseif isa(state, 'function_handle')

    %dt = time_range(2)-time_range(1);
    r = [time_range(1):max_dist:time_range(2)];

    for jj=1:length(r)
        s = state(r(jj));
        dyn_obs = dynamic_obstacles(r(jj)+base_time);
        
        curr_obstacles =[ obstacles;  dyn_obs];
        
        for ii=1:size(state_limits, 1)
            if s(ii) < state_limits(ii, 1) || s(ii) > state_limits(ii, 2)
                ok = false;
                return;
            end
        end
        if collides(curr_obstacles, radius, s)
            ok = false;
            return;
        end
    end

else

    for ii=1:size(state_limits, 1)
        if state(ii) < state_limits(ii, 1) || state(ii) > state_limits(ii, 2)
            ok = false;
            return;
        end
    end
    if collides(obstacles, radius, state)
        ok = false;
        return;
    end
end


end

function [coll] = collides(obstacles, radius, s)

n_obs = size(obstacles, 1);
coll = false;
for ii=1:n_obs
    
    obs = obstacles(ii,:)';
    
    if (s(1)>obs(1) && s(1)<obs(1)+obs(4) && s(2)>obs(2) && s(2)<obs(2)+obs(5) && s(3)>obs(3) && s(3)<obs(3)+obs(6)) || ...
            (s(7)>obs(1) && s(7)<obs(1)+obs(4) && s(8)>obs(2) && s(8)<obs(2)+obs(5) && s(9)>obs(3) && s(9)<obs(3)+obs(6))
        coll = true;
        return;
    end
    
    d1 = s(1:3) - min(max(s(1:3),obs(1:3)),obs(1:3)+obs(4:6));
    d2 = s(7:9) - min(max(s(7:9),obs(1:3)),obs(1:3)+obs(4:6));
    if sum(d1.^2) < radius^2 || sum(d2.^2) < radius^2
        coll = true;
        return;
    end
    
    if(sum((s(1:3)-s(7:9)).^2) < radius^2)
        coll = true;
        return;
    end
    
end
            
end

