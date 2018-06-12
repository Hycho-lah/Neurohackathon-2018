%NeuroHack Whole Dataset
M3 = csvread('tss2');
% M3 = reshape(M1,255,159086);
% M3 = M3.*10;
%Converting to binned spike counts
bin_width = 500;
bin_starts = 1:500:(floor( max(max(M3))/bin_width)-1)*500;
bin_ends = 500:500:(floor( max(max(M3))/bin_width))*500;
bin_pos = 1;
    %Pick one neuron
% for nr = 1:1:size(M3,1)
%         neuron = M3(nr,:);
%         bin_pos = 1;
    while bin_pos < floor(max(max(M3))/bin_width)
        
       M4 = (M3 >= bin_starts(bin_pos) & M3 <=bin_ends(bin_pos));
       
       %Number of spikes in a 500 ms bin is
       
       Neurons_binned(:,bin_pos) = sum(M4,2);
       clear M4 
       bin_pos = bin_pos + 1
       
        
    end
    
    
% end
%Columns = neurons which are the variables , Rows = binned spikes which are
%our observations
%% 
Neurons_binned = Neurons_binned';

[coeff,score,latent,tsquared,explained,mu] = pca(Neurons_binned);
% 
% %Reconstructing data using PCA
% approximationRank2 = score(:,1:2) * coeff(:,1:2)' + repmat(mu, 317, 1);

%% Partitioned dataset
fileID = fopen('type1.txt','r');
formatSpec = '%f';
A = fscanf(fileID,formatSpec);

%% Only Ventral Striatum
id = find(A==2);
ventral_neurons = Neurons_binned(:,id);
clear id

ventral_neurons = ventral_neurons';
[coeff_ventral,score_ventral,latent_ventral,tsquared_ventral,explained_ventral,mu_ventral] = pca(ventral_neurons);

%% Only Dorsal Striatum
id = find(A==1);
dorsal_neurons = Neurons_binned(:,id);
clear id

dorsal_neurons = dorsal_neurons';
[coeff_dorsal,score_dorsal,latent_dorsal,tsquared_dorsal,explained_dorsal,mu_dorsal] = pca(dorsal_neurons);

%% Only motor neurons
id = find(A==0);
motor_neurons = Neurons_binned(:,id);
clear id

motor_neurons = motor_neurons';
[coeff_motor,score_motor,latent_motor,tsquared_motor,explained_motor,mu_motor] = pca(motor_neurons);

%% Behavior
%Read all behavior
load_data










