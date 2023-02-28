function [xy, vX, vY] = simulate_trajectory(x_init, g, data, tMax, tau, vMax, noise_drift)
    xy(:,1) = x_init;
    dtSmall = 0.005;
    t = 0;
    i = 1;
    tauIndex = 1;
    while t < tMax
      % Compute value function gradient
      Deriv = computeGradients(g, data(:, :, end-tauIndex+1));
      deriv = eval_u(g, Deriv, xy(:, i));

      % Compute the optimal control
      vX(i) = -vMax * sign(deriv(1));
      vY(i) = -vMax * sign(deriv(2));
      
      % Compute the next state
      xy(:,i+1) = xy(:,i) + dtSmall*([vX(i); vY(i)] + noise_drift);
      i = i+1;

      % Propagate time
      t = t + dtSmall;
      if t > tau(tauIndex+1)
          tauIndex = tauIndex + 1;
      end
    
    end

end