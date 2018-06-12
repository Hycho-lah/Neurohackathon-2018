reach_durations_mouse1 = zeros(0,1500);
for i = 2:length(reachStart1)
    reach_duration_start = reachStart1(i)-499;
    reach_duration_end = reachStart1(i)+1500;
    reach_durations_mouse1 = [reach_durations_mouse1;[reach_duration_start:1:reach_duration_end]];
end

reach_durations_mouse2 = zeros(0,1500);
for i = 1:length(reachStart2)
    reach_duration_start = reachStart2(i)-499;
    reach_duration_end = reachStart2(i)+1500;
    reach_durations_mouse2 = [reach_durations_mouse2;[reach_duration_start:1:reach_duration_end]];
end

eu_distances_mouse1 = zeros(0,2000);
for i = 1:length(reach_durations_mouse1(:,1))
    distances = [];
    for t = 1:2000
        display(reach_durations_mouse1(i,t));
        x = jsPos1(1,uint8(reach_durations_mouse1(i,t)));
        y = jsPos1(2,uint8(reach_durations_mouse1(i,t)));
        display(x);
        display(y); 
        d = calc_eudistance(x,y);   
        display(d);    
        distances = [distances,d];
    end
    eu_distances_mouse1 = [eu_distances_mouse1;distances];
end

eu_distances_mouse2 = zeros(0,2000);
for i = 1:length(reach_durations_mouse2(:,1))
    distances = [];
    for t = 1:2000
        x = jsPos1(1,reach_durations_mouse2(i,t));
        y = jsPos1(2,reach_durations_mouse2(i,t));
        d = calc_eudistance(x,y);
        distances = [distances,d];
    end
    eu_distances_mouse2 = [eu_distances_mouse2;distances];
end

function d = calc_eudistance(x,y)
    d = sqrt(x*x + y*y);
end