%if reach was reward reach_reward(i) = 1, else reach_reward(i)=0;
reach_reward = zeros(1,length(reachStart1)-1); 
for i = 2:length(reachStart1)
    reachStart = reachStart1(i);
    reachEnd = reachStart + 1400; 
    reachduration = [reachStart:1:reachEnd];
    for r = 1:length(rewTime1)
        rewTime = rewTime1(r);
        if ismember(rewTime,reachduration)
            reach_reward(i) = 1;
        end
    end
end

reach_reward1 = reach_reward;
save('reach_reward1.txt', 'reach_reward','-ascii','-tabs')
%test = importdata('reach_reward.txt');

reach_reward = zeros(1,length(reachStart2));
for i = 1:length(reachStart2)
    reachStart = reachStart2(i);
    reachEnd = reachStart + 1400; 
    reachduration = [reachStart:1:reachEnd];
    for r = 1:length(rewTime2)
        rewTime = rewTime2(r);
        if ismember(rewTime,reachduration)
            reach_reward(i) = 1;
        end
    end
end

reach_reward2 = reach_reward;
save('reach_reward2.txt', 'reach_reward','-ascii','-tabs')

