reach_reward1 = importdata('reach_reward1.txt');
reach_reward2 = importdata('reach_reward2.txt');

figure(1);
hits_mouse1 = sum(reach_reward1 == 1);
reaches_mouse1 = length(reach_reward1);

hits_mouse2 = sum(reach_reward2 == 1);
reaches_mouse2 = length(reach_reward2);

x = categorical({'Mouse1','Mouse2'});
y = [hits_mouse1 reaches_mouse1-hits_mouse1;hits_mouse2 reaches_mouse2-hits_mouse2];
b = bar(x,y,'stacked','BarWidth',0.3);
set(b,{'FaceColor'},{'r';'white'});
ylim([0 200]);
legend('Reaches with hit','Reaches without hit');
ylabel("Reaches");
title("Number of Reaches for each mice");
%reaches_wr_mean = mean(reaches_wr);
%plot(reaches_wr_mean);


