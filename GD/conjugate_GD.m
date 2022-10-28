function conjugate_GD()
    function[mse] = meanSquaredError(y, y_pred)
        diff = (y - y_pred).^2;
        mse = mean(diff, "all");
    end
nTrials = 100;
conjugate_step_size = 1; % start point for minimizing
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
[yVal,yintVal]=networkFProp(xData,network);
[yGrad,~]=networkBProp(network,yintVal);
g = NaN(1,25);
for i=1:size(Weight,1)
    g(i) = -2 .* dot(squeeze(yData-yVal), squeeze(yGrad(:, i, :)));
end
d = -1 .* g;
RMS(1)=meanSquaredError(yData, yVal);
for iTrial=2:nTrials
    fun = @(a) meanSquaredError(yData, networkFProp(xData, setNNWeight(network, Weight + a .* d)));
    conjugate_step_size = fminsearch(fun, conjugate_step_size);
    % update weight
    Weight = Weight + conjugate_step_size .* d;
    [network]=setNNWeight(network, Weight);
    % evaluate gradient for the next iteration
    [yVal,yintVal]=networkFProp(xData,network);
    [yGrad,~]=networkBProp(network,yintVal);
    next_g = NaN(1, 25);
    for i=1:size(Weight,1)
        next_g(i) = -2 .* dot(squeeze(yData-yVal), squeeze(yGrad(:, i, :)));
    end
    % calculate beta using the Fletcher–Reeves method
    beta = dot(transpose(next_g), next_g) ./ dot(transpose(g), g);
    d = -1 .* next_g + beta .* d;
    RMS(iTrial)=meanSquaredError(yData, yVal);
    g = next_g;
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