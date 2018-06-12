%% CP Decomposition

% THE CODE USES THE tensor_toolbox
% It can be downloaded from www.tensortoolbox.com ; Developed by Sandia
% National Laboratories
%MATLAB Tensor Toolbox.
%Copyright 2017, Sandia Corporation.
%% Permute all matrices for tensor decomposition
% N x T x K 

%Decomposition rank.
rank = 10;

%% BINNED DATA

binreach_neural_motor = permute(bin_reach_neural_motor,[2 3 1]);
binprep_neural_motor = permute(bin_prep_neural_motor,[2 3 1]);

binreach_neural_dorsal = permute(bin_reach_neural_dorsal,[2 3 1]);
binprep_neural_dorsal = permute(bin_prep_neural_dorsal,[2 3 1]);

binreach_neural_ventral = permute(bin_reach_neural_ventral,[2 3 1]);
binprep_neural_ventral = permute(bin_prep_neural_ventral,[2 3 1]);

bintotal_neural_motor = permute(bin_total_neural_motor,[2 3 1]);
bintotal_neural_dorsal = permute(bin_total_neural_dorsal,[2 3 1]);
bintotal_neural_ventral = permute(bin_total_neural_ventral,[2 3 1]);
%% SEPARATING DATA BY PREPARATORY ACTIVITY, REACH, AND AREA
% FIT MODEL INDIVIDUALLY TO EACH EPOCH

 %Motor 
reach_model_motor = cp_als(tensor(binreach_neural_motor), rank); % fit CP model with rank components

prep_model_motor = cp_als(tensor(binprep_neural_motor), rank); % fit CP model with rank components

total_model_motor = cp_als(tensor(bintotal_neural_motor),rank);

% Dorsal

reach_model_dorsal = cp_als(tensor(binreach_neural_dorsal), rank); % fit CP model with rank components

prep_model_dorsal = cp_als(tensor(binprep_neural_dorsal), rank);

total_model_dorsal = cp_als(tensor(bintotal_neural_dorsal),rank);

%Ventral

reach_model_ventral = cp_als(tensor(binreach_neural_ventral), rank); % fit CP model with rank components

prep_model_ventral = cp_als(tensor(binprep_neural_ventral), rank);

total_model_ventral = cp_als(tensor(bintotal_neural_ventral),rank);



%% Vis data
%Visualize the factors fit using cp_als above

vizopts = {'PlotCommands',{'bar','line','line'},...
    'ModeTitles',{'Neural factors','Temporal factors','Trial factors'},...
    'BottomSpace',0.10,'HorzSpace',0.04,'Normalize',0,'FactorTitles',{'Weight'},'SameYlims','false'};
info1 = viz(reach_model_ventral,'Figure',2,vizopts{:});


