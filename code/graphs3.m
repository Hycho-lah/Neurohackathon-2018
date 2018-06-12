type1 = importdata('type1.txt');
type2 = importdata('type2.txt');

quadrant1 = importdata('quadrant1.txt');
quadrant2 = importdata('quadrant2.txt');

reach_neuron_matrix1 = zeros(163,255);
for r = 1:length(datStruct1)
    for n = 1:255
        spikes = sum(datStruct1(r).neuralDat(n,:));
        reach_neuron_matrix1(r,n) = spikes;
    end
end

reach_neuron_matrix_weighted1 = zeros(163,0);
type_weighted1 = [];
for i = 1:length(goodNeurons1)
    if goodNeurons1(i)
        reach_neuron_matrix_weighted1 = cat(2, reach_neuron_matrix_weighted1, reach_neuron_matrix1(:,i));
        type_weighted1 = [type_weighted1;type1(i)];
    end
end
x = reach_neuron_matrix_weighted1;
y = ampVel1(:,2);

v_lmdl1 = fitlm(x,y);

reach_neuron_matrix_m1 = zeros(163,0);
reach_neuron_matrix_d1 = zeros(163,0);
reach_neuron_matrix_v1 = zeros(163,0);
for i = 1:length(reach_neuron_matrix_weighted1(1,:))
    if type_weighted1(i) == 0
        reach_neuron_matrix_m1 = cat(2, reach_neuron_matrix_m1, reach_neuron_matrix_weighted1(:,i));
    elseif type_weighted1(i) == 1
        reach_neuron_matrix_d1 = cat(2, reach_neuron_matrix_d1, reach_neuron_matrix_weighted1(:,i));
    elseif type_weighted1(i) == 2
        reach_neuron_matrix_v1 = cat(2, reach_neuron_matrix_v1, reach_neuron_matrix_weighted1(:,i));
    end
end
x = reach_neuron_matrix_m1;
v_m_lmdl1 = fitlm(x,y);

x = reach_neuron_matrix_d1;
v_d_lmdl1 = fitlm(x,y);

x = reach_neuron_matrix_v1;
v_v_lmdl1 = fitlm(x,y);

    
reach_neuron_matrix2 = zeros(170,385);
for r = 1:length(datStruct2)
    for n = 1:385
        spikes = sum(datStruct2(r).neuralDat(n,:));
        reach_neuron_matrix2(r,n) = spikes;
    end
end
x = reach_neuron_matrix_weighted2;

y = ampVel2(:,2);
v_lmdl2 = fitlm(x,y);

reach_neuron_matrix_weighted2 = zeros(170,0);
type_weighted2 = [];
c = 0;
for i = 1:length(goodNeurons2)
    if goodNeurons2(i) 
        reach_neuron_matrix_weighted2 = cat(2, reach_neuron_matrix_weighted2, reach_neuron_matrix2(:,i));
        type_weighted2 = [type_weighted2;type2(i)];
    end
end


reach_neuron_matrix_m2 = zeros(170,0);
reach_neuron_matrix_d2 = zeros(170,0);
reach_neuron_matrix_v2 = zeros(170,0);
for i = 1:length(reach_neuron_matrix_weighted2(1,:))
    if type_weighted2(i) == 0
        reach_neuron_matrix_m2 = cat(2, reach_neuron_matrix_m2, reach_neuron_matrix_weighted2(:,i));
    elseif type_weighted2(i) == 1
        reach_neuron_matrix_d2 = cat(2, reach_neuron_matrix_d2, reach_neuron_matrix_weighted2(:,i));
    elseif type_weighted2(i) == 2
        reach_neuron_matrix_v2 = cat(2, reach_neuron_matrix_v2, reach_neuron_matrix_weighted2(:,i));
    end
end
x = reach_neuron_matrix_m2;
v_m_lmdl2 = fitlm(x,y);

x = reach_neuron_matrix_d2;
v_d_lmdl2 = fitlm(x,y);

x = reach_neuron_matrix_v2;
v_v_lmdl2 = fitlm(x,y);

figure(1);
x = categorical({'Motor','DS','VS'});
y = [v_m_lmdl1.MSE,v_m_lmdl2.MSE;  v_d_lmdl1.MSE, v_d_lmdl2.MSE; v_v_lmdl1.MSE, v_v_lmdl2.MSE];
bar(x,y);

figure(2); 
x = categorical({'Motor','DS','VS'});
name = {'Motor','DS','VS'};
y = [v_m_lmdl1.Rsquared.Ordinary,v_m_lmdl2.Rsquared.Ordinary;  v_d_lmdl1.Rsquared.Ordinary, v_d_lmdl2.Rsquared.Ordinary; v_v_lmdl1.Rsquared.Ordinary, v_v_lmdl2.Rsquared.Ordinary];
b = bar(y);
title('R^2 for Linear Regression Models fitted by Peak Velocity')
ylabel('R^2')
legend('Mouse1','Mouse2');
ylim([0 1])
set(gca,'xticklabel',name)