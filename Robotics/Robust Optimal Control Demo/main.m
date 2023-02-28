clear all; close all; clc;

%% Dynamics parameters
nX = 2; % States - [p_x, p_y]
nU = 2; % Controls - [v_x, v_y]
nD = 2; % Disturbance - [d_x, d_y]
vMax = 1; % Maximum speed - 1 m/s
dMax = 0.2; % Maximum drift - (+-) 0.01 m/s 
noise_drift = [0; -0.2]; 

%% Setup environment parameters
goalX = 1;
goalY = 5;
obsCenterY = 3;
obsSizeY = 1;
obsCenterX = 1;
obsSizeX = 1;

%% Setup grid for dynamic programming
grid_min = [-2; -1]; % Lower corner of computation domain
grid_max = [4; 6];    % Upper corner of computation domain
N = [51; 51];         % Number of grid points per dimension
g = createGrid(grid_min, grid_max, N);

%% Set the terminal value function
% Penalize the distance from the goal state
f1 = (g.xs{1} - goalX).^2 + (g.xs{2} - goalY).^2;
% Visualize f1
figure;
visFuncIm(g, f1, 'green', 0.5);
hold on;
xlabel('x position');
ylabel('y position');
zlabel('f1');
% Create obstacle
viscircles([obsCenterX, obsCenterY], [obsSizeX], 'color', 'r');
% Create goal point
viscircles([goalX, goalY], [0.1], 'color', 'g');
hold off;

% Penalize if the robot goes inside the obstacle
f2 = max(obsSizeX - sqrt(((g.xs{1} - obsCenterX).^2) + ((g.xs{2} - obsCenterY).^2)), 0);
% Visualize f2
figure;
visFuncIm(g, f2, 'red', 0.5);
hold on;
xlabel('x position');
ylabel('y position');
zlabel('f2');
% Create obstacle
viscircles([obsCenterX, obsCenterY], [obsSizeX], 'color', 'r');
% Create goal point
viscircles([goalX, goalY], [0.1], 'color', 'g');
hold off;

data0 = f1 + 50*f2;
% Visualize f
figure;
visFuncIm(g, data0, 'blue', 0.5);
hold on;
xlabel('x position');
ylabel('y position');
zlabel('Terminal value function');
% Create obstacle
viscircles([obsCenterX, obsCenterY], [obsSizeX], 'color', 'r');
% Create goal point
viscircles([goalX, goalY], [0.1], 'color', 'g');
hold off;

close all;

%% Time horizon for applying dynamic programming
t0 = 0;
tMax = 7.5;
dt = 0.5;
tau = t0:dt:tMax;

%% Pack the problem parameters for dynamic programming
schemeData.grid = g; % Grid over which the value function is computed
schemeData.hamFunc = @dubins2Dham;
schemeData.partialFunc = @dubins2Dpartial;
schemeData.runningCost = data0 * 1.0;
schemeData.vMax = vMax;
schemeData.dMax = dMax;
schemeData.uMode = 'min'; % Control is trying to minimize the cost function
schemeData.dMode = 'max'; % Disturbance is trying to maximize the cost function
schemeData.tMode = 'backward';

%% Start dynamic programming from the terminal value function
HJIextraArgs.visualize.initialValueFunction = 1;
HJIextraArgs.visualize.valueFunction = 1;
HJIextraArgs.visualize.figNum = 1; %set figure number
HJIextraArgs.visualize.deleteLastPlot = false; %delete previous plot as you update
HJIextraArgs.visualize.xTitle = 'x position';
HJIextraArgs.visualize.yTitle = 'y position';
HJIextraArgs.visualize.zTitle = 'Value Function';
HJIextraArgs.visualize.viewGrid = true;
[data, tau, ~] = HJIPDE_solve(data0, tau, schemeData, 'none', HJIextraArgs);

%% Visualize the final value function (heatmap and 3D)
% 2D function
figure;
visFuncIm(g, data(:, :, end), 'blue', 0.5);
hold on;
xlabel('x position');
ylabel('y position');
zlabel('Value Function');
% Create obstacle
viscircles([obsCenterX, obsCenterY], [obsSizeX], 'color', 'r');
% Create goal point
viscircles([goalX, goalY], [0.1], 'color', 'g');
hold off;

% Heatmap
figure;
contourf(g.xs{1}, g.xs{2}, data(:, :, end), [-1:100]);
hold on;
xlabel('x position');
ylabel('y position');
% Create obstacle
viscircles([obsCenterX, obsCenterY], [obsSizeX], 'color', 'r');
% Create goal point
viscircles([goalX, goalY], [0.1], 'color', 'g');

%% Trajectory simulation
xinit = [1; 0]; % Initial state
[xy, ~, ~] = simulate_trajectory(xinit, g, data, tMax, tau, vMax, noise_drift);
viscircles([xy(1, 1), xy(2, 1)], [0.05], 'color', 'magenta');
plot(xy(1, :), xy(2, :), 'color', 'white', 'linestyle', '-', 'LineWidth', 4);

xinit = [3; 2]; % Initial state
[xy, ~, ~] = simulate_trajectory(xinit, g, data, tMax, tau, vMax, noise_drift);
viscircles([xy(1, 1), xy(2, 1)], [0.05], 'color', 'magenta');
plot(xy(1, :), xy(2, :), 'color', 'white', 'linestyle', '-', 'LineWidth', 4);

xinit = [-1.7; 4]; % Initial state
[xy, ~, ~] = simulate_trajectory(xinit, g, data, tMax, tau, vMax, noise_drift);
viscircles([xy(1, 1), xy(2, 1)], [0.05], 'color', 'magenta');
plot(xy(1, :), xy(2, :), 'color', 'white', 'linestyle', '-', 'LineWidth', 4);
