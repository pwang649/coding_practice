function [x,y]=getData(nData,nInput,StudentID)
%
% Description:generate nData data points (x_k,y_k), k=1,...,nData where
%   x_k are vectors with nInput entries and y_k takes value 0 or 1.
% Usage: [x,y]=getData(nData,nInput,StudentID)
%        [x,y]=getData(nData,nInput,StudentID,iplot)
%     Inputs:
%       nData         : Number of data points (x_k,y_k).
%       nInput        : Dimension of input vactors x_k.
%       StudentID     : 10 Digit student ID number.
%     Outputs:
%       x             : nInput by nData array.
%       y             : 1 by nData array of zeros and ones.
%
rng(StudentID);
%
x0=10*randn(nInput,1);
r0=2*abs(randn(nInput,1));
%
x=80*(rand(nInput,nData)-0.5);
%
dist=sqrt(sum(((x-x0*ones(1,nData))./(r0*ones(1,nData))).^2,1));
y=zeros(1,nData);
y(dist<=10)=1;
z=rand(1,nData);
ind=find(z>0.95);
y(ind)=1-y(ind);
return
end