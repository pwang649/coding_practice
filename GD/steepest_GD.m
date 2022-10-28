function steepest_GD()
    function[mse] = meanSquaredError(y, y_pred)
        diff = (y - y_pred).^2;
        mse = mean(diff, "all");
    end

nTrials = 100;
steepest_step_size = 1; % start point for minimizing
epsilon = 1e-5; % minmal convergence error
[xData,yData]=getData(100,2,2338580531);
[network]=createNetwork(2,[3,3,1]);
[Weight]=getNNWeight(network);
Weight=randn(size(Weight));
RMS=NaN(nTrials,1);
[network]=setNNWeight(network,Weight);
prev_yVal = 1;
convergence = -1;
runOnce = 1;
for iTrial=1:nTrials
    [yVal,yintVal]=networkFProp(xData,network);
    [yGrad,~]=networkBProp(network,yintVal);
    f = NaN(1,25);
    for i=1:size(Weight,1)
        f(i) = -2 .* dot(squeeze(yData-yVal), squeeze(yGrad(:, i, :)));
    end
    fun = @(a) meanSquaredError(yData, networkFProp(xData, setNNWeight(network, Weight - a .* f)));
    steepest_step_size = fminsearch(fun, steepest_step_size);
    Weight = Weight - steepest_step_size .* f;
    [network]=setNNWeight(network, Weight);
    RMS(iTrial)=meanSquaredError(yData, yVal);
    if (all(abs(yVal - prev_yVal) < epsilon) && runOnce == 1)
        convergence = iTrial;
        runOnce = 0;
    end
    prev_yVal = yVal;
end
disp(['it converges in ' num2str(convergence) ' iterations.']);
figure;
plot(RMS);
min(RMS)
return
end