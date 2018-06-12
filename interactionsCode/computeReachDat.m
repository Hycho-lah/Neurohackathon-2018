clear; clc; close all;

subIdx = 1;

neuralDat = importdata(['tss' num2str(subIdx)]);

if subIdx==1
    neuralDat = neuralDat.*10; % correcting for an error (see slack for details)
    nNeurons = 255;
elseif subIdx==2
    nNeurons = 385;
else
    error('ERR');
end
reachTimes = importdata(['reachStart' num2str(subIdx)]);
if subIdx==1
    reachTimes = reachTimes(2:end);
end
jsPos = importdata(['jsPos' num2str(subIdx)]);
ampVel = importdata(['ampVel' num2str(subIdx)]);
reaches = importdata(['reaches' num2str(subIdx)]);
t = -499:1000;

datStruct = [];
for i_trial = 1:length(reachTimes)
    datStruct(i_trial).amp = ampVel(i_trial,1);
    datStruct(i_trial).vel = ampVel(i_trial,2);
    datStruct(i_trial).reaches = reaches(i_trial,:);
    datStruct(i_trial).t = t;
    
    datStruct(i_trial).reachTime = reachTimes(i_trial);
    
    idx = (reachTimes(i_trial)-499) : (reachTimes(i_trial)+1000);
    datStruct(i_trial).reachIdx = idx;
    datStruct(i_trial).jsPos = jsPos(:,idx);
    
    tmpMat = false(nNeurons,length(t));
    for i_neuron = 1:nNeurons
        tmp = neuralDat(i_neuron,(neuralDat(i_neuron,:) > idx(1)) & (neuralDat(i_neuron,:) < idx(end)));
        tmp = floor(tmp);
        tmp = tmp - idx(1) + 1;
        tmpMat(i_neuron,tmp) = true;
    end
    datStruct(i_trial).neuralDat = tmpMat;
end

tmp = [datStruct.neuralDat];
meanFRs = sum(tmp,2)./length(datStruct)./1.5;
goodNeurons = meanFRs>1;

fname = ['dat' num2str(subIdx)];
save(fname,'datStruct','goodNeurons');
