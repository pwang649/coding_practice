function [v,varargout]=Sigmoid(xVal)
%
% Description: Sigmoid function and its derivative.
%        v = 1/(1+exp(-x))
% Usage: [v]=Sigmoid(xVal)
%        [v,vPrime]=Sigmoid(xVal)
%    Inputs:
%        xValue    : Value of the independent variable.
%    Outputs:
%        v         : Value of the sigmoid function.
%        vPrime    : Derivative of the sigmoid function.
%
% Author: Chunming Wang
% Creation Date: October 14, 2018
%
v=1./(1+exp(-xVal));
if nargout>1
    varargout{1}=exp(-xVal)./((1+exp(-xVal)).^2);
end
return