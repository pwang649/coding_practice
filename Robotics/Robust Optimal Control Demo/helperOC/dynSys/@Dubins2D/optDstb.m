function dOpt = optDstb(obj, ~, ~, deriv, dMode)
% dOpt = optCtrl(obj, t, y, deriv, dMode)
%     Dynamics of the DubinsCar
%         \dot{x}_1 = v * cos(x_3) + d_1
%         \dot{x}_2 = v * sin(x_3) + d_2

%% Input processing
if nargin < 5
  dMode = 'max';
end

if ~iscell(deriv)
  deriv = num2cell(deriv);
end

dOpt = cell(obj.nd, 1);

%% Optimal control
if strcmp(dMode, 'max')
  for i = 1:2
      dOpt{i} = (deriv{i}>=0)*obj.dRange{2}(i) + ...
        (deriv{i}<0)*(obj.dRange{1}(i));
  end

elseif strcmp(dMode, 'min')
  for i = 1:2
      dOpt{i} = (deriv{i}>=0)*(obj.dRange{1}(i)) + ...
        (deriv{i}<0)*obj.dRange{2}(i);
  end
  
else
  error('Unknown dMode!')
end

end