function [yVal,varargout]=networkFProp(xVal,network)
%
% Description: evaluate the output of a neural network.
% Usage: [yVal]=networkFProp(xVal,network)
%        [yVal,yintVal]=networkFProp(xVal,network)
%    Inputs:
%        xVal        : Array of dimension n by m for m vectors of input
%                      data to the neural 
%        network     : Structure array that defines structure of a neural 
%                      network and coefficient values.
%    Outputs:
%        yVal        : Array of dimension p by m for m vectors of response.
%        yintVal     : Structure array of intermediate values to be used in
%                      back propagation.
%
% Author: Chunming Wang
% Creation Date: October 14, 2018
%
nLayer=length(network);
xDim=size(xVal);
wDim=size(network(1).Weight);
%
% Verify that the dimension of input is consistent with the network.
%
if xDim(1)~=(wDim(2)-1)
    disp('networFProp: Dimension of input is incompatible with the network.');
    yVal=[];
    return;
end
%
% Loop over layers
%
yintVal=struct('Output',cell(1,nLayer+1),'Grad',cell(1,nLayer+1));
yintVal(1).Output=xVal;
yintVal(1).Grad=zeros(xDim);
for iLayer=1:nLayer
    wDim=size(network(iLayer).Weight);
    yintVal(iLayer+1).Output=zeros(wDim(1),xDim(2));
    yintVal(iLayer+1).Grad=zeros(wDim(1),xDim(2));
    xVal=[xVal;ones(1,xDim(2))];
    for iNode=1:wDim(1)
        [yintVal(iLayer+1).Output(iNode,:),yintVal(iLayer+1).Grad(iNode,:)]=...
            SingleNeuron(xVal,network(iLayer).Weight(iNode,:)',network(iLayer).Activation);
    end
    xVal=yintVal(iLayer+1).Output;
end
yVal=yintVal(end).Output;
if nargout>1
    varargout{1}=yintVal;
end
return
end