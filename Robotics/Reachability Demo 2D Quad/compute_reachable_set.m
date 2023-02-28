clear; clc; close all;

%% Grid
grid_min = [0; -3]; % Lower corner of computation domain
grid_max = [3; 4];    % Upper corner of computation domain
N = [151; 151];         % Number of grid points per dimension
g = createGrid(grid_min, grid_max, N);

%% target set
lower_height = 0.5;
upper_height = 2.5;
data0 = -shapeRectangleByCorners(g, [lower_height; grid_min(2)], [upper_height; grid_max(2)]);

% Visualize the failure set
figure;
visFuncIm(g, data0, 'red', 0.5);
hold on;
xlabel('z position');
ylabel('z velocity');
zlabel('l(x)');
hold off;

%% time vector
t0 = 0;
tMax = 1.0;
dt = 0.1;
tau = t0:dt:tMax;

%% problem parameters
u = [0, 1.0];
k1 = 15;
dMax = 0;

%% Pack problem parameters
schemeData.grid = g; % Grid MUST be specified!

% Dynamical system parameters
schemeData.grid = g;
schemeData.k1 = k1;
schemeData.g = -9.81;
schemeData.hamFunc = @quad2Dham;
schemeData.partialFunc = @quad2Dpartial;
schemeData.urange = u;
schemeData.uMode = 'max';
schemeData.dMode = 'min';
schemeData.tMode = 'backward';
schemeData.disturbance = dMax;

%% Start reachability computation
targets = data0;
extraArgs.targets = targets;
extraArgs.visualize = true;

numPlots = 4;
spC = ceil(sqrt(numPlots));
spR = ceil(numPlots / spC);

[data, tau, ~] = HJIPDE_solve(data0, tau, schemeData, 'minVwithL', extraArgs);
