function uOpt = optCtrl(obj, t, xs, deriv, uMode, ~)
% uOpt = optCtrl(obj, t, deriv, uMode, dMode, MIEdims)

%% Optimal control
if iscell(deriv)
  uOpt = cell(obj.nu, 1);
  deriv_angle = atan2(deriv{2}, deriv{1});
  if strcmp(uMode, 'max')
    uOpt{1} = deriv_angle;
    
  elseif strcmp(uMode, 'min')
    uOpt{1} = wrapToPi(pi + deriv_angle);
    
  else
    error('Unknown uMode!')
  end  
  
else
  uOpt = zeros(obj.nu, 1);
  deriv_angle = atan2(deriv(2), deriv(1));
  if strcmp(uMode, 'max')
    uOpt(1) = deriv_angle;
    
  elseif strcmp(uMode, 'min')
    uOpt(1) = wrapToPi(pi + deriv_angle);
    
  else
    error('Unknown uMode!')
  end
end




end