function [network]=setNNWeight(network,Weight)
%
% Description: Set the weight from the array structure for a neural
%    network and return them as a vector. The network is assumed to be
%    created with 'createNetwork.m'
% Usage: [network]=setNNWeight(network,Weight)
%    Inputs:
%        network     : structure array created by 'createNetwork.m'.
%        Weight      : vector of weights.
%    Outputs:
%        network     : structure array created by 'createNetwork.m'.
%
nLayer=length(network);
nWeight=zeros(nLayer,1);
for iLayer=1:nLayer
    nWeight(iLayer)=numel(network(iLayer).Weight);
end
if sum(nWeight) ~= length(Weight)
    disp('setNNWeight: input Weight and network are incompatible.');
    return;
end
iWeight=0;
for iLayer=1:nLayer
    network(iLayer).Weight=reshape(Weight(iWeight+1:iWeight+nWeight(iLayer)),size(network(iLayer).Weight));
    iWeight=iWeight+nWeight(iLayer);
end
return
end