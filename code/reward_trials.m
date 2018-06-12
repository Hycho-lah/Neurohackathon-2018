reach_reward1 = importdata('reach_reward1.txt');
reach_reward2 = importdata('reach_reward2.txt');

figure(1);
y = movmean(reach_reward1,50);
plot([1:163],y);
ylim([0 1]);
xlim([0 170]);
xlabel('Trials');
ylabel('Reward Rate');
title('Reward Rate Across trials for Mouse 1');

figure(2);
y = movmean(reach_reward2,50);
plot([1:170],y);
ylim([0 1]);
ylim([0 1]);
xlim([0 170]);
xlabel('Trials');
ylabel('Reward Rate');
title('Reward Rate Across trials for Mouse 2');

figure(3); 
y = ampVel1(:,1);
plot([1:163],y);
xlabel('Trials');
ylabel('Peak Amplitude');
title('Peak Amplitude by Trials for Mouse 1');

figure(4); 
y = ampVel2(:,1);
plot([1:170],y);
xlabel('Trials');
ylabel('Peak Amplitude');
title('Peak Amplitude by Trials for Mouse 2');

figure(5); 
y = ampVel1(:,2);
plot([1:163],y);
xlabel('Trials');
ylabel('Peak Velocity');
title('Peak Velocity by Trials for Mouse 1');

figure(6); 
y = ampVel2(:,2);
plot([1:170],y);
xlabel('Trials');
ylabel('Peak Velocity');
title('Peak Velocity by Trials for Mouse 2');





