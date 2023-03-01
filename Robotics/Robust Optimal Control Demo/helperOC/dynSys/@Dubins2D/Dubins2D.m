classdef Dubins2D < DynSys
  properties
    % Speed
    speed

    % Disturbance
    dRange
  end
  
  methods
      function obj = Dubins2D(x, speed, dRange)
      % Dynamics:
      %    \dot{x}_1 = speed * cos(theta) + d1
      %    \dot{x}_2 = speed * sin(theta) + d2
      %
      
      if numel(x) ~= 2
        error('Initial state does not have right dimension!');
      end
      
      if ~iscolumn(x)
        x = x';
      end
      
      if nargin < 3
        dRange = {[0; 0];[0; 0]};
      end
      
      obj.x = x;
      obj.xhist = obj.x;
      
      obj.speed = speed;
      obj.dRange = dRange;
      
      obj.pdim = 1:2;
      
      obj.nx = 2;
      obj.nu = 1;
      obj.nd = 2;
    end
    
  end % end methods
end % end classdef
