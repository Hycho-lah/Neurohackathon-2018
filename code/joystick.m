reach_reward = importdata('reach_reward1.txt');

number_wr = sum(reach_reward == 1);
number_wor = sum(reach_reward == 0);
reaches_wr = zeros(0,1500);
reaches_wor = zeros(0,1500);

reachStart_wr = [];
reachStart_wor = [];
for i = 1:(length(reachStart1)-1)
    if reach_reward(i) == 1
        reachStart_wr = [reachStart_wr,reachStart1(i)];
    elseif reach_reward(i) == 0
        reachStart_wor = [reachStart_wor,reachStart1(i)];
    end 
end

rewTime_hits = [];
reach_duration_hits = zeros(0,1500);
reachStart_hits = [];
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
            rewTime_hits = [rewTime_hits,rewTime];
            reachStart_hits = [reachStart_hits,reachStart1(r)];
        end
    end 
end

reward_induration_time = [];
for i = 1:length(rewTime_hits)
    rewTime_induration = rewTime_hits(i)-(reachStart_hits(i)-499);
    reward_induration_time = [reward_induration_time,rewTime_induration];
end

for i = 1:length(reaches1(:,1))
    if reach_reward(i) == 1 
        reaches_wr = [reaches_wr;reaches1(i,:)];
    elseif reach_reward(i) == 0 
        reaches_wor = [reaches_wor;reaches1(i,:)];
    end
end


figure(2);
plot(jsPos1(1,1:2006968),jsPos1(2,1:2006968));
xlim([-1500 1500]);
ylim([-2000 3000]);
hold on 
plot([-1500 1500], [0 0],'black')
hold on 
plot([0 0], [-2000 3000],'black')

figure(3);
for i = 1:length(reaches_wr(:,1))
    plot([1:1500],reaches_wr(i,:),'blue');
    hold on 
end

for i = 1:length(reward_induration_time)
    hold on;
    plot([reward_induration_time(i) reward_induration_time(i)], [-2000 3000]);
    hold on;
end

figure(4);
for i = 1:length(reaches_wor(:,1))
    plot([1:1500],reaches_wor(i,:),'blue');
    hold on 
end
%reaches_wr_mean = mean(reaches_wr);
%plot([1:1500],reaches_wr_mean,'LineWidth',3,'black');


figure(5);
plot([1:1500],reaches_wr(1,:));
hold on;
plot([reward_induration_time(1) reward_induration_time(1)], [-2000 3000]);

figure(6); 
for i = 1:length(reaches_wr(:,1))
    plot([1:1500],reaches_wr(i,:),'blue');
    hold on 
end

plot([mean(reward_induration_time) mean(reward_induration_time)], [-2000 3000]);


