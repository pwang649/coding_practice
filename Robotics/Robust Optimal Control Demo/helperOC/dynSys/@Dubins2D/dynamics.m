function dx = dynamics(obj, t, x, u, d)
% Dynamics of the Plane
%    \dot{x}_1 = speed * cos(theta) + d1
%    \dot{x}_2 = speed * sin(theta) + d2
%   Control: u = [theta];
%

if numel(u) ~= obj.nu
  error('Incorrect number of control dimensions!')
end

if iscell(x)
  dx = cell(obj.nx, 1);

  if nargin < 5
    d = {0 0};
  end
  
  % Kinematic plane (speed can be changed instantly)
  dx{1} = obj.speed * cos(u{1}) + d{1};
  dx{2} = obj.speed * sin(u{1}) + d{2};
else
  dx = zeros(obj.nx, 1);

  if nargin < 5
    d = [0; 0];
  end
  
  % Kinematic plane (speed can be changed instantly)
  dx(1) = obj.speed * cos(u(1)) + d(1);
  dx(2) = obj.speed * sin(u(1)) + d(2);
end


end