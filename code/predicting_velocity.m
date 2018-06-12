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
y = [v_m_lmdl1.Rsquared.Ordinary,v_m_lmdl2.Rsquared.Ordinary;  v_d_lmdl1.Rsquared.Ordinary, v_d_lmdl2.Rsquared.Ordinary; v_v_lmdl1.Rsquared.Ordinary, v_v_lmdl2.Rsquared.Ordinary];
bar(x,y);
title('R^2 for Linear Regression Models')
title('PCA for Spikes of each Trial across Neurons for Mouse 1');
xlabel('PC1');
ylabel('PC2');
zlabel('PC3');


figure(3);
x = categorical({'Motor','DS','VS'});
y = [v_m_lmdl1.Rsquared.Adjusted,v_m_lmdl2.Rsquared.Adjusted;  v_d_lmdl1.Rsquared.Adjusted, v_d_lmdl2.Rsquared.Adjusted; v_v_lmdl1.Rsquared.Adjusted, v_v_lmdl2.Rsquared.Adjusted];
bar(x,y);


figure(4);
[coeff,score,latent] = pca(reach_neuron_matrix_weighted1);
scatter3(score(:,1),score(:,2),score(:,3));
title('PCA for Spikes of each Trial across Neurons for Mouse 1');
xlabel('PC1');
ylabel('PC2');
zlabel('PC3');

figure(5);
score_wr = zeros(0,length(score(1,:)));
score_wor = zeros(0,length(score(1,:)));
for r = 1:length(reach_reward1)
    if reach_reward1(r) == 1
        score_instance = score(r,:);
        score_wr = [score_wr; score_instance];
    elseif reach_reward1(r) == 0
        score_instance = score(r,:);
        score_wor = [score_wor; score_instance];
    end
end

scatter3(score_wr(:,1),score_wr(:,2),score_wr(:,3),'red');
hold on 
scatter3(score_wor(:,1),score_wor(:,2),score_wor(:,3),'blue');
title('PCA for Spikes of each Trial across Neurons for Mouse2');
xlabel('PC1');
ylabel('PC2');
zlabel('PC3');


figure(6);
score_q1 = zeros(0,length(score(1,:)));
score_q2 = zeros(0,length(score(1,:)));
score_q3 = zeros(0,length(score(1,:)));
score_q4 = zeros(0,length(score(1,:)));
for r = 1:length(reach_reward1)
    if quadrant1(r) == 0
        score_instance = score(r,:);
        score_q1 = [score_q1; score_instance]
    elseif quadrant1(r) == 1
        score_instance = score(r,:);
        score_q2 = [score_q2; score_instance]
    elseif quadrant1(r) == 2
        score_instance = score(r,:);
        score_q3 = [score_q3; score_instance]
    elseif quadrant1(r) == 3
        score_instance = score(r,:);
        score_q4 = [score_q4; score_instance];
    end
end

scatter3(score_q1(:,1),score_q1(:,2),score_q1(:,3),'red');
hold on 
scatter3(score_q2(:,1),score_q2(:,2),score_q2(:,3),'blue');
hold on
scatter3(score_q3(:,1),score_q3(:,2),score_q3(:,3),'green');
hold on
scatter3(score_q4(:,1),score_q4(:,2),score_q4(:,3),'yellow');
title('PCA for Spikes of each Trial across Neurons for Mouse1');
xlabel('PC1');
ylabel('PC2');
zlabel('PC3');


figure(7);
[coeff,score,latent] = pca(transpose(reach_neuron_matrix_weighted1));
scatter(score(:,1),score(:,2));

figure(8);
[coeff,score,latent] = pca(reach_neuron_matrix_weighted2);
scatter3(score(:,1),score(:,2),score(:,3));
title('PCA for Spikes of each Trial across Neurons for Mouse2');
xlabel('PC1');
ylabel('PC2');
zlabel('PC3');


figure(9);
score_wr = zeros(0,length(score(1,:)));
score_wor = zeros(0,length(score(1,:)));
for r = 1:length(reach_reward2)
    if reach_reward2(r) == 1
        score_instance = score(r,:);
        score_wr = [score_wr; score_instance];
    elseif reach_reward2(r) == 0
        score_instance = score(r,:);
        score_wor = [score_wor; score_instance];
    end
end

scatter3(score_wr(:,1),score_wr(:,2),score_wr(:,3),'red');
hold on 
scatter3(score_wor(:,1),score_wor(:,2),score_wor(:,3),'blue');
title('PCA for Spikes of each Trial across Neurons for Mouse2');
xlabel('PC1');
ylabel('PC2');
zlabel('PC3');

figure(10);
score_q1 = zeros(0,length(score(1,:)));
score_q2 = zeros(0,length(score(1,:)));
score_q3 = zeros(0,length(score(1,:)));
score_q4 = zeros(0,length(score(1,:)));
for r = 1:length(reach_reward2)
    if quadrant2(r) == 0
        score_instance = score(r,:);
        score_q1 = [score_q1; score_instance]
    elseif quadrant2(r) == 1
        score_instance = score(r,:);
        score_q2 = [score_q2; score_instance]
    elseif quadrant2(r) == 2
        score_instance = score(r,:);
        score_q3 = [score_q3; score_instance]
    elseif quadrant2(r) == 3
        score_instance = score(r,:);
        score_q4 = [score_q4; score_instance];
    end
end

scatter3(score_q1(:,1),score_q1(:,2),score_q1(:,3),'red');
hold on 
scatter3(score_q2(:,1),score_q2(:,2),score_q2(:,3),'blue');
hold on
scatter3(score_q3(:,1),score_q3(:,2),score_q3(:,3),'green');
hold on
scatter3(score_q4(:,1),score_q4(:,2),score_q4(:,3),'yellow');
title('PCA for Spikes of each Trial across Neurons for Mouse2');
xlabel('PC1');
ylabel('PC2');
zlabel('PC3');

