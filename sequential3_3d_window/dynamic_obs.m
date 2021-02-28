function obs = dynamic_obs(t,dynobs1,dynobs2)
    obs = [];
    if(~isempty(dynobs1))
        [~,id] = min(abs(t-dynobs1(:,1)));
        obs =  [obs;dynobs1(id,2:end)];
    end
    if(~isempty(dynobs2))
        [~,id] = min(abs(t-dynobs2(:,1)));
        obs =  [obs;dynobs2(id,2:end)];
    end
end

