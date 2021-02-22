function obs = dynamic_obs(dyn_obs,t)
    [~,id] = min(abs(t-dyn_obs(:,1)));
    obs =  dyn_obs(id,2:end);
end

