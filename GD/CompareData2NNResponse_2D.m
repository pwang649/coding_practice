function CompareData2NNResponse_2D(xData,yData,network)
%
% Description: Compare classification data with 2 independent variables to
%  the response of a neural network with 2 inputs and a single output.
% Usage: CompareData2NNResponse_2D(xData,yData,network)
%    Inputs:
%       xData     : 2 by n array of independent data.
%       yData     : binary vector of length n.
%       network   : Structure array defining a neural network.
%
nDim=size(xData);
if nDim(1)~=2
    disp('CompareData2NNResponse_2D: This routine can only analyze input data of 2 dimension.');
    return;
end
if length(nDim)~=2
    disp('CompareData2NNResponse_2D: Input data must be a 2D array.');
    return;
end    
if numel(yData)~=nDim(2)
    disp('CompareData2NNResponse_2D: The number of dependent variable y must be identical to the number of input vectors x.');
    return;
end
ind=find((yData~=1)&(yData~=0));
if ~isempty(ind)
    disp('CompareData2NNResponse_2D: Dependent variable y can only take value 0 or 1.');
    return;
end
[nOutput,nInput]=size(network(1).Weight);
if nInput~=3
    disp('CompareData2NNResponse_2D: Neural network must have 2 inputs.');
    return;
end
[nOutput,nInput]=size(network(end).Weight);
if nOutput~=1
    disp('CompareData2NNResponse_2D: Neural network must have a single output.');
    return;
end
xMin=min(xData,[],2);
xMax=max(xData,[],2);
x1=xMin(1)+(xMax(1)-xMin(1))*[0:100]/100;
x2=xMin(2)+(xMax(2)-xMin(2))*[0:100]/100;
xVal=[reshape(ones(101,1)*x1,1,101*101);reshape(x2'*ones(1,101),1,101*101)];
[yVal]=networkFProp(xVal,network);
yVal=reshape(yVal,101,101);
%
figure;
set(gcf,'Position',[100,100,1000,450],'Color','w');
h1=subplot('Position',[0.075,0.1,0.4,0.8]);
hold on
ind=find(yData==1);
plot(xData(1,ind),xData(2,ind),'o','MarkerFaceColor','r','MarkerEdgeColor','r','MarkerSize',[3]);
ind=find(yData==0);
plot(xData(1,ind),xData(2,ind),'o','MarkerFaceColor','b','MarkerEdgeColor','b','MarkerSize',[3]);
box on
title('Training/Validation Data');
xlabel('x_1');
ylabel('x_2');
h2=subplot('Position',[0.475,0.1,0.45,0.8]);
imagesc(x1,x2,yVal);
title('Neural Network Response');
xlabel('x_1');
ylabel('x_2');
set(gca,'YAxisLocation','right','YDir','normal');
h=colorbar('Location','EastOutside');
ylabel(h,'Neural Network Output');
return
end