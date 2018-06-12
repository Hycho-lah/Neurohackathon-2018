rewTime_hits1 = [];
reach_duration_hits = zeros(0,1500);
reachStart_hits1 = [];
for i = 1:length(rewTime1)
    rewTime = rewTime1(i);
    for r = 2:(length(reachStart1))
        reward_duration_start = reachStart1(r);
        reward_duration_end = reachStart1(r) + 1400; 
        reward_duration = [reward_duration_start:1:reward_duration_end];
        if ismember(rewTime,reward_duration)
            reach_duration_start = reachStart1(r)-499;
            reach_duration_end = reachStart1(r)+1000;
            reach_duration = [reach_duration_start:1:reach_duration_end];
            reach_duration_hits = [reach_duration_hits;reach_duration];
            rewTime_hits1 = [rewTime_hits1,rewTime];
            reachStart_hits1 = [reachStart_hits1,reachStart1(r)];
        end
    end 
end

rewTime_hits2 = [];
reach_duration_hits = zeros(0,1500);
reachStart_hits2 = [];
for i = 1:length(rewTime2)
    rewTime = rewTime2(i);
    for r = 2:(length(reachStart2))
        reward_duration_start = reachStart2(r);
        reward_duration_end = reachStart2(r) + 1400; 
        reward_duration = [reward_duration_start:1:reward_duration_end];
        if ismember(rewTime,reward_duration)
            reach_duration_start = reachStart1(r)-499;
            reach_duration_end = reachStart1(r)+1000;
            reach_duration = [reach_duration_start:1:reach_duration_end];
            reach_duration_hits = [reach_duration_hits;reach_duration];
            rewTime_hits2 = [rewTime_hits2,rewTime];
            reachStart_hits2 = [reachStart_hits2,reachStart2(r)];
        end
    end 
end

figure(1);
y = cumsum(reach_reward1);
plot(rewTime_hits1) 