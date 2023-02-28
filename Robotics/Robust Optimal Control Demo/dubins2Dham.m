function hamValue = dubins2Dham(t, data, deriv, schemeData)
% hamValue = dubins2Dham(deriv, schemeData)
%   Hamiltonian function for Dubins car used with the level set toolbox
%
% Inputs:
%   schemeData - problem parameters
%     .grid:   grid structure
%     .vMax: speed bound for x and y directions
%     .dMax: speed bound for the disturbance
%     .uMode:  'min' or 'max' (defaults to 'min')
%     .tMode: 'backward' or 'forward'
%
% Dynamics:
%   \dot x      = v_x + d_x
%   \dot y      = v_y + d_y

checkStructureFields(schemeData, 'grid', 'vMax', 'dMax', 'runningCost', 'uMode', 'dMode');

vMax = schemeData.vMax;
dMax = schemeData.dMax;

%% Compute Hamiltonian
% Running cost - constant term of the Hamiltonian 
hamRunning = schemeData.runningCost;

% Control component - min_u p1*v_x + p2*v_y
hamCtrl = -vMax * (abs(deriv{1}) + abs(deriv{2}));

% Disturbance component - max_d p1*d_x + p2*d_y
hamDstb = dMax * (abs(deriv{1}) + abs(deriv{2}));

hamValue = hamRunning + hamCtrl + hamDstb;

%% Backward or forward reachable set
if strcmp(schemeData.tMode, 'backward')
  hamValue = -hamValue;
else
  error('tMode must be ''backward''!')
end
end
