function [RegressionModel]=L1_MultilinearRegression(X,Y)
%
% Description: Calculate the multilinear regression using L1 norm, that is:
%    miminize Sum(|y_k-a_0-a_1x_{k,1}-...-a_mx_{k,m}|).
% Usage: [RegressionModel]=L1_MultilinearRegression(X,Y)
%   Inputs: 
%       X      : array of dimension m by n.
%       Y      : vector of length n.
%   Output:
%       RegressionModel  : structure array with the following fields:
%            Coefficients : vector of length m.
%            Intersect    : constant for a_0.
%            Prediction   : vector of length n representing
%                           y_k-a_0-a_1x_{k,1}-...-a_mx_{k,m}.
%            SRE          : sum of residual error.
%
[m,n]=size(X);
if length(Y)~=n
    disp('L1_MultilinearRegression: The data X and Y must have identical length');
    RegressionModel=[];
    return;
end
%
% Construct constrain matrix A
%
A=[X',-X',ones(n,1),-ones(n,1),eye(n),-eye(n)];
b=reshape(Y,n,1);
c=zeros(2*m+2+2*n,1);
c(end-2*n+1:end)=1;
ind=find(b<0);
b(ind)=-b(ind);
A(ind,:)=-A(ind,:);
BasicVar0=2*m+2+[1:n];
BasicVar0(ind)=BasicVar0(ind)+n;
%
% Perform linear programming
%
[Solution,BasicVar,Status]=basicsimplex(A,b,c,BasicVar0);
if Status==-1
    disp('L1_MultilinearRegression: Linear programming failed unexpectedly');
    RegressionModel=[];
    return;
end
RegressionModel=struct('Coefficients',ones(m,1),'Intersect',0,'Prediction',zeros(n,1),'SRE',0);
for k=1:m
    if ~isempty(find(BasicVar==k))
        RegressionModel.Coefficients(k)=Solution(k);
    elseif ~isempty(find(BasicVar==k+m))
        RegressionModel.Coefficients(k)=-Solution(k+m);
    end
end
if ~isempty(find(BasicVar==2*m+1))
    RegressionModel.Intersect=Solution(2*m+1);
elseif ~isempty(find(BasicVar==2*m+2))
    RegressionModel.Intersect=-Solution(2*m+2);
end
RegressionModel.Prediction=X'*RegressionModel.Coefficients+RegressionModel.Intersect;
RegressionModel.SRE=sum(abs(Y'-RegressionModel.Prediction));
return
end

