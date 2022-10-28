function [network]=createNetwork(nInput,Layers,varargin)
%
% Description: create data structure for a feed-forward neuron network
% Usage: [network]=createNetwork(nInput,Layers)
%        [network]=createNetwork(nInput,Layers, Activation)
%    Inputs:
%       nInput      : number of input at the first layer.
%       Layers      : a vector of integers specifies the number of neurons
%                     from each layer.
%       Activation  : activation function object. Default (sigmoid)
%    Output: 
%       network     : a structure data array specifying the dimension of
%                     the input and weights for neurons. The number of
%                     layers of the network is equal to the length of the 
%                     input vector Layers. The weigth array of each layer has 
%                     dimension equal to the previous layer of neurons plus
%                     one by the number of the neuron in the layer. The 
%                     dimension of weight for the first layer is equal to 
%                     the number of inputs plus one by the number of
%                     neurons in the first layer.
%                      
% Author: Chunming Wang
% Creation Date: October 14, 2018
%
Activation=@Sigmoid;
if nargin>2
    Activation=varargin{1};
end
network=struct('Weight',cell(1,length(Layers)));
Layers=[nInput,reshape(Layers,1,numel(Layers))];
for iLayer=1:length(Layers)-1
    network(iLayer).Weight=ones(Layers(iLayer+1),Layers(iLayer)+1);
    network(iLayer).Activation=Activation;
end
return
end