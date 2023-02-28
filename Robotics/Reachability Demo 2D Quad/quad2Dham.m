function hamValue = quad2Dham(t, data, deriv, schemeData)
% hamValue = quad2Dham(deriv, schemeData)
%   Hamiltonian function for a 2D quadrotor model (in z direction) used with the level set toolbox
% Dynamics:
%   \dot x      = v_x
%   \dot v_x    = k1*u + g + d
% Somil Bansal, 2018-09-07

checkStructureFields(schemeData, 'grid', 'urange', 'disturbance');

g = schemeData.grid;

% Dynamics parameters
k1 = schemeData.k1;
gravity = schemeData.g;

uMin = schemeData.urange(1);
uMax = schemeData.urange(2);
dMax = schemeData.disturbance;


%% Defaults: min over control, backward reachable set
if ~isfield(schemeData, 'uMode')
  schemeData.uMode = 'max';
end

if ~isfield(schemeData, 'dMode')
  schemeData.dMode = 'min';
end

if ~isfield(schemeData, 'tMode')
  schemeData.tMode = 'backward';
end

%% Modify Hamiltonian control terms based on uMode
uOpt = uMin*(deriv{2} <= 0) + uMax*(deriv{2} > 0);

%% Modify Hamiltonian control terms based on dMode
dOpt = dMax*(deriv{2} <= 0) - dMax*(deriv{2} > 0);

%% Hamiltonian control terms
% Speed control
hamValue = g.xs{2}.* deriv{1} + deriv{2}.*(k1*uOpt + gravity + dOpt);

%% Backward or forward reachable set
if strcmp(schemeData.tMode, 'backward')
  hamValue = -hamValue;
else
  error('tMode must be ''backward''!')
end
end
