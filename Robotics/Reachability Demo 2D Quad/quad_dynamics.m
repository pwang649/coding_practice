function dx = quad_dynamics(t, state, ctrl, k1, g, d)
% Impletement the dynamics of a 2D quadrotor
% Dynamics:
%   \dot x      = v_x
%   \dot v_x    = k1*u + g + d
% Somil Bansal, 2018-09-07

dx = zeros(2, 1);
dx(1) = state(2);
dx(2) = k1*ctrl + g + d;