function [yVal,ygrad]=SingleNeuron(xVal,Weight,varargin)
%
% Description: Model of a single neuron.
% Usage: 
%   [yVal,grady]=SingleNeuron(xVal,Weight)
%   [yVal,grady]=SingleNeuron(xVal,Weight,Activation)
%   Inputs:
%      xVal       : Array size n by m for m input vectors.
%      Weight     : Array size n by 1 for the Weight vectors or
%                   array size n by 1 for the Weight vectors
%      Activation : Function object for activation function.
%   Outputs:
%      yVale      : Vector with m components for output of single neuron.
%      ygrad      : Vector with m components for the derivative of the
%                   activation function.
%
Activation = @Sigmoid;
if nargin>2
    Activation=varargin{1};
end
xDim=size(xVal);
wDim=size(Weight);
yVal=[];
ygrad=[];
if xDim(1) ~= wDim(1)
    disp('SingleNeuron: The row dimension of xVal and Weight must be identical.');
    return;
end
if xDim(2)== wDim(2)
    [yVal,ygrad]=Activation(sum(Weight.*xVal,1));
elseif wDim(2)==1
    [yVal,ygrad]=Activation(Weight'*xVal);
else
    disp('SingleNeuron: The column dimension of Weight must be either 1 or the same as xVal.');
    return;
end
return
end
