function [Weight]=getNNWeight(network)
%
% Description: Extract the weight from the array structure for a neural
%    network and return them as a vector. The network is assumed to be
%    created with 'createNetwork.m'
% Usage: [Weight]=getNNWeight(network)
%    Inputs:
%        network     : structure array created by 'createNetwork.m'.
%    Outputs:
%        Weight      : vector of weights.
%
nLayer=length(network);
nWeight=zeros(nLayer,1);
for iLayer=1:nLayer
    nWeight(iLayer)=numel(network(iLayer).Weight);
end
Weight=zeros(sum(nWeight),1);
iWeight=0;
for iLayer=1:nLayer
    Weight(iWeight+1:iWeight+nWeight(iLayer))=reshape(network(iLayer).Weight,nWeight(iLayer),1);
    iWeight=iWeight+nWeight(iLayer);
end
return
end