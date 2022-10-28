function Experiment_Basic_NNTools(nTrials)
    function[mse] = meanSquaredError(y, y_pred)
        diff = (y - y_pred).^2;
        mse = mean(diff, "all");
    end
%
% Description: This is a script the performs a test of basic neural network
% routines.
% Usage: Experiment_Basic_NNTools(nTrials)
%
nTrials=100;
[xData,yData]=getData(100,2,1234567890);
figure;
ind0=find(yData==0);
ind1=find(yData==1);
bar([0,1],[length(ind0),length(ind1)]);
%
[network]=createNetwork(2,[2,4,1]);
VisualizeNN(network);
%
% Initialize network using randomly generated weights.
%
[Weight]=getNNWeight(network);
Weight=squeeze(0.01*randn([size(Weight),nTrials]));
RMS=NaN(nTrials,1);
for iTrial=1:nTrials
    [network]=setNNWeight(network,Weight(:,iTrial));
    [yVal,~]=networkFProp(xData,network);
    RMS(iTrial)=meanSquaredError(yData, yVal);
end
figure;
hist(RMS,20);
return
end