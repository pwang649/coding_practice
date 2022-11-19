function Test_L1Regression
%
n=50;
m=1;
X=10*randn(m,n)
Coef=20*randn(m+1,1)
Y=Coef(1:m)'*X+Coef(m+1)+30*randn(1,n)
%
[RegressionModel]=L1_MultilinearRegression(X,Y);
%
% Least square
%
Xhat=X-mean(X,2)*ones(1,n);
Yhat=Y-mean(Y);
Coef_LSQ=inv(Xhat*Xhat')*Xhat*Yhat';
Intersect_LSQ=mean(Y)-Coef_LSQ'*mean(X,2);
Prediction=Coef_LSQ'*X+Intersect_LSQ;
%
figure;
plot(Y,RegressionModel.Prediction,'o','MarkerSize',[8],'MarkerFaceColor','r','MarkerEdgeColor','r');
hold on
plot(Y,Prediction,'o','MarkerSize',[8],'MarkerFaceColor','b','MarkerEdgeColor','b');
%
figure;
plot(Y'-RegressionModel.Prediction,'o','MarkerSize',[8],'MarkerFaceColor','r','MarkerEdgeColor','r');
hold on
plot(Y-Prediction,'o','MarkerSize',[8],'MarkerFaceColor','b','MarkerEdgeColor','b');

RegressionModel.SRE
sum(abs(Y-Prediction))
return;
end