function alpha = quad2Dpartial(t, data, derivMin, derivMax, schemeData, dim)
% Dynamics:
%   \dot x      = v_x
%   \dot v_x    = k1*u + g + d
% Somil Bansal, 2018-09-07

checkStructureFields(schemeData, 'grid', 'urange', 'disturbance');

g = schemeData.grid;
k1 = schemeData.k1;
gravity = schemeData.g;

uMin = schemeData.urange(1);
uMax = schemeData.urange(2);
disturbance = schemeData.disturbance;

switch dim
  case 1
    % Control
    alpha = abs(g.xs{2});
    
  case 2
    % Control
    alpha = abs(k1*uMax) + abs(gravity) + abs(disturbance); 
    
end
end