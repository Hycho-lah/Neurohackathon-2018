clear; clc; close all;
addpath('myCCA');

%% parameters
binSize = 50;

%% load data
load('dat2.mat');
quadLabels = importdata('quadrant2.txt');
neuronType = importdata('type2.txt');
neuronType = neuronType(goodNeurons);
nNeurons = sum(goodNeurons);
nTrials = length(datStruct);
motorLabel = 0;
dorsalLabel = 1;
ventralLabel = 2;
nT = 1500/binSize;
t = linspace(-500+binSize/2,1000-binSize/2,nT);

% get spike counts
binnedData = nan(nNeurons,nT,nTrials);
for i_trial = 1:nTrials
    currDat = datStruct(i_trial).neuralDat(goodNeurons,:);
    for i_t = 1:nT
        currIdx = ((i_t-1)*binSize+1) : (i_t*binSize);
        binnedData(:,i_t,i_trial) = sum(currDat(:,currIdx),2);
    end     
end

prepData = binnedData(:,1:floor(nT/3),:);
reachData = binnedData(:,floor(nT/3)+1:end,:);

%% separate into area specific prepatory and reach datasets
motorPrepDat = prepData(neuronType==motorLabel,:,:);
motorReachDat = reachData(neuronType==motorLabel,:,:);
nMotor = sum(neuronType==motorLabel);
motorPrepDat = reshape(motorPrepDat,nMotor,[])';
motorReachDat = reshape(motorReachDat,nMotor,[])';

dorsalPrepDat = prepData(neuronType==dorsalLabel,:,:);
dorsalReachDat = reachData(neuronType==dorsalLabel,:,:);
nDorsal = sum(neuronType==dorsalLabel);
dorsalPrepDat = reshape(dorsalPrepDat,nDorsal,[])';
dorsalReachDat = reshape(dorsalReachDat,nDorsal,[])';

ventralPrepDat = prepData(neuronType==ventralLabel,:,:);
ventralReachDat = reachData(neuronType==ventralLabel,:,:);
nVentral = sum(neuronType==ventralLabel);
ventralPrepDat = reshape(ventralPrepDat,nVentral,[])';
ventralReachDat = reshape(ventralReachDat,nVentral,[])';

motorDorsalPrep = crossval_pCCA(motorPrepDat',dorsalPrepDat','numFolds',10,'zDimList',0:6);
motorDorsalReach = crossval_pCCA(motorReachDat',dorsalReachDat','numFolds',10,'zDimList',0:6);

motorVentralPrep = crossval_pCCA(motorPrepDat',ventralPrepDat','numFolds',10,'zDimList',0:6);
motorVentralReach = crossval_pCCA(motorReachDat',ventralReachDat','numFolds',10,'zDimList',0:6);

ventralDorsalPrep = crossval_pCCA(dorsalPrepDat',ventralPrepDat','numFolds',10,'zDimList',0:6);
ventralDorsalReach = crossval_pCCA(dorsalReachDat',ventralReachDat','numFolds',10,'zDimList',0:6);
