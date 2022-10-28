function test_Basic_NNTools




%
% Description: This is a script the performs a test of basic neural network
% routines.
% Usage: test_Basic_NNTools
%
[network]=createNetwork(2,[4,4,2]);
VisualizeNN(network);
%
% Initialize network using randomly generated weights.
%
[Weight]=getNNWeight(network);
Weight=0.01*randn(size(Weight));
[network]=setNNWeight(network,Weight);
%
% Test the output of the network
%
x1=-1+2*[0:1000];
x2=x1'*ones(1,1001);
x1=ones(1001,1)*x1;
xVal=[reshape(x1,1,numel(x1));reshape(x2,1,numel(x2))];
[yVal]=networkFProp(xVal,network);
y1=reshape(yVal(1,:),1001,1001);
y2=reshape(yVal(2,:),1001,1001);
figure;
subplot('Position',[0.1,0.1,0.4,0.8]);
imagesc([-10,10],[-10,10],y1);
xlabel('x_1');
ylabel('x_2');
title('y_1');
subplot('Position',[0.5,0.1,0.4,0.8]);
imagesc([-10,10],[-10,10],y2);
xlabel('x_1');
ylabel('x_2');
title('y_2');
set(gca,'YAxisLocation','right');
%
% Generate random data.
%
xVal=randn(2,100);
[yVal,yintVal]=networkFProp(xVal,network);
[yGrad,yGrad_Struct]=networkBProp(network,yintVal);
%
% Test gradient.
%
dWeight=0.00001*randn(size(Weight));
[network]=setNNWeight(network,Weight+dWeight);
[yVal_new,yintVal_new]=networkFProp(xVal,network);
%
delta_yVal=yVal_new-yVal;
ad_yVal=zeros(size(delta_yVal));
for k=1:100
    ad_yVal(:,k)=yGrad(:,:,k)*dWeight;
end
%
relative_err=100*(delta_yVal-ad_yVal)./delta_yVal;
figure;
plot(relative_err');
xlabel('Order of Input');
ylabel('Relative Error in Output Variation (percent)');
%
[network]=createNetwork(2,[4,4,1]);
VisualizeNN(network);
[x,y]=getData(100,2,2338580531);
CompareData2NNResponse_2D(x,y,network)
return
end