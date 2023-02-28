function alpha = dubins2Dpartial(t, data, derivMin, derivMax, schemeData, dim)
% Inputs:
%   schemeData - problem parameters
%     .grid: grid structure
%     .vMax: speed bound for x and y directions
%     .dMax: speed bound for the disturbance
%
% Dynamics:
%   \dot x      = v_x + d_x
%   \dot y      = v_y + d_y

checkStructureFields(schemeData, 'grid', 'vMax', 'dMax');

vMax = schemeData.vMax;
dMax = schemeData.dMax;


switch dim
  case 1
    alpha = vMax + dMax;
    
  case 2
    alpha = vMax + dMax;
    
end
end