clear; clc; close all;
addpath('~/Documents/grad_projects/ByronMatt/code/bayesClassifier/');
addpath('pCorr');
rmpath('../glasso');


%% parameters
binSize = 250;
corrThresh = 0.01;
pThresh = 0.05;
lassoReg = .3;
nBoot = 100;

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
reachData = binnedData(:,floor(nT/3)+1:floor(2*nT/3),:);

%% motor cortex
motorPrepDat = prepData(neuronType==motorLabel,:,:);
motorReachDat = reachData(neuronType==motorLabel,:,:);
nMotor = sum(neuronType==motorLabel);
motorPrepDat = reshape(motorPrepDat,nMotor,[])';
motorReachDat = reshape(motorReachDat,nMotor,[])';

[motorPrepTheta, ~] = graphicalLasso(cov(motorPrepDat,1),lassoReg);
[motorReachTheta, ~] = graphicalLasso(cov(motorReachDat,1),lassoReg);

figure; pos=get(gcf,'Position'); set(gcf,'Position',pos.*[1 1 2 1]);
subplot(1,2,1); hold on;
nConn_motorPrep = visualizeGlasso(motorPrepTheta); 
axis off;
title(sprintf('motor prep (%d)',nConn_motorPrep));
subplot(1,2,2); hold on;
nConn_motorReach = visualizeGlasso(motorReachTheta); 
axis off;
title(sprintf('motor reach (%d)',nConn_motorReach));
drawnow
motorDiff = nConn_motorReach - nConn_motorPrep;
% 
% allMotorDat = [motorPrepDat; motorReachDat];
% trialType = [zeros(size(motorPrepDat,1),1); ones(size(motorReachDat,1),1)];
% motorBootDiff = nan(1,nBoot);
% startParPool(nBoot);
% parfor i_boot = 1:nBoot
%     tmpTrialType = trialType(randperm(length(trialType)));
%     tmpDat1 = allMotorDat(tmpTrialType==1,:);
%     tmpDat2 = allMotorDat(tmpTrialType==0,:);
%     [theta1, ~] = graphicalLasso(cov(tmpDat1,1),lassoReg);
%     [theta2, ~] = graphicalLasso(cov(tmpDat2,1),lassoReg);
%     theta1_conn = (sum(theta1(:)>1e-5)-nNeurons)/2;
%     theta2_conn = (sum(theta2(:)>1e-5)-nNeurons)/2;
%     motorBootDiff(i_boot) = theta1_conn - theta2_conn;
% end
% save('bootstrapMotor.mat','motorDiff','motorBootDiff');


% [motorPrepData_pCorr,motorPrepData_pVals] = partialcorr(reshape(motorPrepDat,nMotor,[])');
% [motorReachData_pCorr,motorReachData_pVals] = partialcorr(reshape(motorReachDat,nMotor,[])');
% figure; hold on;
% visualizeCorr(motorPrepData_pCorr,motorPrepData_pVals,1:nMotor,corrThresh,pThresh);
% title('motor cortex prep');
% figure; hold on;
% visualizeCorr(motorReachData_pCorr,motorReachData_pVals,1:nMotor,corrThresh,pThresh);
% title('motor cortex reach');

%% dorsal striatum
dorsalPrepDat = prepData(neuronType==dorsalLabel,:,:);
dorsalReachDat = reachData(neuronType==dorsalLabel,:,:);
nDorsal = sum(neuronType==dorsalLabel);
dorsalPrepDat = reshape(dorsalPrepDat,nDorsal,[])';
dorsalReachDat = reshape(dorsalReachDat,nDorsal,[])';

[dorsalPrepTheta, ~] = graphicalLasso(cov(dorsalPrepDat,1),.3);
[dorsalReachTheta, ~] = graphicalLasso(cov(dorsalReachDat,1),.3);

figure; pos=get(gcf,'Position'); set(gcf,'Position',pos.*[1 1 2 1]);
subplot(1,2,1); hold on;
nConn_dorsalPrep = visualizeGlasso(dorsalPrepTheta); 
axis off;
title(sprintf('dorsal prep (%d)',nConn_dorsalPrep));
subplot(1,2,2); hold on; 
nConn_dorsalReach = visualizeGlasso(dorsalReachTheta); 
axis off;
title(sprintf('dorsal reach (%d)',nConn_dorsalReach));
drawnow
dorsalDiff = nConn_dorsalReach - nConn_dorsalPrep;

% alldorsalDat = [dorsalPrepDat; dorsalReachDat];
% trialType = [zeros(size(dorsalPrepDat,1),1); ones(size(dorsalReachDat,1),1)];
% dorsalBootDiff = nan(1,nBoot);
% startParPool(nBoot);
% parfor i_boot = 1:nBoot
%     tmpTrialType = trialType(randperm(length(trialType)));
%     tmpDat1 = alldorsalDat(tmpTrialType==1,:);
%     tmpDat2 = alldorsalDat(tmpTrialType==0,:);
%     [theta1, ~] = graphicalLasso(cov(tmpDat1,1),lassoReg);
%     [theta2, ~] = graphicalLasso(cov(tmpDat2,1),lassoReg);
%     theta1_conn = (sum(theta1(:)>1e-5)-nNeurons)/2;
%     theta2_conn = (sum(theta2(:)>1e-5)-nNeurons)/2;
%     dorsalBootDiff(i_boot) = theta1_conn - theta2_conn;
% end
% save('bootstrapDorsal.mat','dorsalDiff','dorsalBootDiff');

% [dorsalPrepData_pCorr,dorsalPrepData_pVals] = partialcorr(reshape(dorsalPrepDat,nDorsal,[])');
% [dorsalReachData_pCorr,dorsalReachData_pVals] = partialcorr(reshape(dorsalReachDat,nDorsal,[])');
% figure; hold on;
% visualizeCorr(dorsalPrepData_pCorr,dorsalPrepData_pVals,1:nDorsal,corrThresh,pThresh);
% title('dorsal striatum prep');
% figure; hold on;
% visualizeCorr(dorsalReachData_pCorr,dorsalReachData_pVals,1:nDorsal,corrThresh,pThresh);
% title('dorsal striatum reach');


%% ventral striatum
ventralPrepDat = prepData(neuronType==ventralLabel,:,:);
ventralReachDat = reachData(neuronType==ventralLabel,:,:);
nVentral = sum(neuronType==ventralLabel);
ventralPrepDat = reshape(ventralPrepDat,nVentral,[])';
ventralReachDat = reshape(ventralReachDat,nVentral,[])';

[ventralPrepTheta, ~] = graphicalLasso(cov(ventralPrepDat,1),.3);
[ventralReachTheta, ~] = graphicalLasso(cov(ventralReachDat,1),.3);

figure; pos=get(gcf,'Position'); set(gcf,'Position',pos.*[1 1 2 1]);
subplot(1,2,1); hold on;
nConn_ventralPrep = visualizeGlasso(ventralPrepTheta); 
axis off;
title(sprintf('ventral prep (%d)',nConn_ventralPrep));
subplot(1,2,2); hold on;
nConn_ventralReach = visualizeGlasso(ventralReachTheta); 
axis off;
title(sprintf('ventral reach (%d)',nConn_ventralReach));
drawnow
ventralDiff = nConn_ventralReach - nConn_ventralPrep;

% allventralDat = [ventralPrepDat; ventralReachDat];
% trialType = [zeros(size(ventralPrepDat,1),1); ones(size(ventralReachDat,1),1)];
% ventralBootDiff = nan(1,nBoot);
% startParPool(nBoot);
% parfor i_boot = 1:nBoot
%     tmpTrialType = trialType(randperm(length(trialType)));
%     tmpDat1 = allventralDat(tmpTrialType==1,:);
%     tmpDat2 = allventralDat(tmpTrialType==0,:);
%     [theta1, ~] = graphicalLasso(cov(tmpDat1,1),lassoReg);
%     [theta2, ~] = graphicalLasso(cov(tmpDat2,1),lassoReg);
%     theta1_conn = (sum(theta1(:)>1e-5)-nNeurons)/2;
%     theta2_conn = (sum(theta2(:)>1e-5)-nNeurons)/2;
%     ventralBootDiff(i_boot) = theta1_conn - theta2_conn;
% end
% save('bootstrapVentral.mat','ventralDiff','ventralBootDiff');


% [ventralPrepData_pCorr,ventralPrepData_pVals] = partialcorr(reshape(ventralPrepDat,nVentral,[])');
% [ventralReachData_pCorr,ventralReachData_pVals] = partialcorr(reshape(ventralReachDat,nVentral,[])');
% figure; hold on;
% visualizeCorr(ventralPrepData_pCorr,ventralPrepData_pVals,1:nVentral,corrThresh,pThresh);
% title('ventral striatum prep');
% figure; hold on;
% visualizeCorr(ventralReachData_pCorr,ventralReachData_pVals,1:nVentral,corrThresh,pThresh);
% title('ventral striatum reach');

% prep = ventralPrepData_pCorr(ventralPrepData_pCorr<.99);
% reach = ventralReachData_pCorr(ventralReachData_pCorr<.99);
% figure; hold on; histogram(abs(prep)); histogram(abs(reach))
