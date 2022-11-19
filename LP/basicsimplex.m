function [Solution,BasicVar,Status]=basicsimplex(A,b,c,BasicVar0)
%
% Description: Basic simplex method for linear programming
% Usage: [Solution,BasicVar,Status]=basicsimplex(A,b,c,BasicVar0)
%   Inputs:
%       A         : Array of dimension m by n for the equality constraints
%                   Ax=b.
%       b         : Vector of dimension m for the right hand side of the
%                   equality constraints. 
%       c         : The weights for the cost functional.
%       BasicVar0 : Indices of variables in the initial basic solution.
%   Outputs:                
%       Solution  : Optimal solution when exists.
%       BasicVar  : Indices of basis variables for the solution.
%       Status    : Status of the solution. Status = 0 if the solution is
%                   optimal. Status = -1 if no optimal solution exits.
%
[mConstr,ndim]=size(A);
Solution=[];
BasicVar=[];
Status=-1;
if numel(b)~= mConstr
    disp('basicsimplex: Sizes of matrix A and vector b are inconsistent.');
    return;
end
if numel(BasicVar0)~= mConstr
    disp('basicsimplex: The number of basic variable must be equal to the number of constraints.');
    return;
end
BasicVar0=unique(BasicVar0);
if numel(BasicVar0)~= mConstr
    disp('basicsimplex: Indices of basic variables must not repeat.');
    return;
end
if numel(c) ~= ndim
    disp('basicsimplex: Dimensions of matrix A and vector c are inconsistent.');
    return;
end
b=reshape(b,mConstr,1);
c=reshape(c,ndim,1);
%
% Initialize the simplex table
%
A_basic=A(:,BasicVar0);
A=inv(A_basic)*A;
b=inv(A_basic)*b;
if min(b)<0
    disp('basicsimplex: Components of the initial basic solution must be all non negative.');
    Solution=b;
    BasicVar=BasicVar0;
    Status=-1;
    return;
end
%
%  Basic simplex method
%
Opt_Flag=-1;
NonBasicVar=[1:ndim];
NonBasicVar(BasicVar0)=-1;
NonBasicVar=find(NonBasicVar>0);
ReduceCost=zeros(ndim,1);
BasicVar=BasicVar0;
while Opt_Flag == -1
    %
    % Compute the reduced cost coefficients.
    %
    ReduceCost(BasicVar)=inf;
    ReduceCost(NonBasicVar)=c(NonBasicVar)-A(:,NonBasicVar)'*c(BasicVar);
    if min(ReduceCost)>=0
        Opt_Flag=1;
        Status=0;
        Solution=zeros(ndim,1);
        Solution(BasicVar)=b;
        return;
    end
    %
    % Select non-basic variable to enter basis.
    %
    [v,indCandidate]=min(ReduceCost);
    Slack=inf(mConstr,1);
    ind=find(A(:,indCandidate)>0);
    if isempty(ind)
        Opt_Flag=1;
        Status=-1;
        Solution=zeros(ndim,1);
        Solution(BasicVar)=b;
        return;
    end        
    Slack(ind)=b(ind)./A(ind,indCandidate);
    [v,indOut]=min(Slack);    
    b(indOut)=b(indOut)/A(indOut,indCandidate);
    A(indOut,:)=A(indOut,:)/A(indOut,indCandidate);
    indRest=find([1:mConstr]~=indOut);
    b(indRest)=b(indRest)-A(indRest,indCandidate)*b(indOut);
    A(indRest,:)=A(indRest,:)-A(indRest,indCandidate)*A(indOut,:);
    NonBasicVar(NonBasicVar==indCandidate)=BasicVar(indOut);
    BasicVar(indOut)=indCandidate;
end
return
end
    