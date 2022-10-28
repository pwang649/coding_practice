format short g
format compact

theta1=.8;theta2=1.2;
seed=41754;rand('state',seed)
n=10;
u=rand(n,1); % a column vector of n standard uniforms
x=u.^(-1/theta1); % the .^ notation takes the power, for each element of the vector
y=u.^(-1/theta2); % X and Y will be maximally correlated
results=[u,x,y]   %  semicolon to suppressed output BUT comma or no semicolon to show output
means_n=[mean(results),n]  % even when you can see all the data, a summary is nice to have
stds_n=[std(results),n]  % this is the sample SD, ie. SD+.   For large n it will tend to sqrt(1/12)=.28868

seed=41754;rand('state',seed)
n=1000
u=rand(n,1); % a column vector of n standard uniforms
x=u.^(-1/theta1); % the .^ notation takes the power, for each element of the vector
y=u.^(-1/theta2); % X and Y will be maximally correlated
results=[u,x,y];   %  semicolon to suppressed output BUT comma or no semicolon to show output
results(1:12,:)  % show first 12 rows, and all columns
means_n=[mean(results),n]  % even when you can see all the data, a summary is nice to have
stds_n=[std(results),n]  % this is the sample SD, ie. SD+.   For large n it will tend to sqrt(1/12)=.28868

tic  % set up a timer, to see how much pain a million samples cost
seed=41754;rand('state',seed)
n=10^8
u=rand(n,1); % a column vector of n standard uniforms
x=u.^(-1/theta1); % the .^ notation takes the power, for each element of the vector
y=u.^(-1/theta2); % X and Y will be maximally correlated
results=[u,x,y];   %  semicolon to suppressed output BUT comma or no semicolon to show output
results(1:12,:)  % show first 12 rows, and all columns
means_n=[mean(results),n]  % even when you can see all the data, a summary is nice to have
stds_n=[std(results),n]  % this is the sample SD, ie. SD+.   For large n it will tend to sqrt(1/12)=.28868
toc  % see the elapsed time since the last tic  (get it,  tick tock goes the clock)


