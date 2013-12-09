function [wandOffset] = getWandOffset(t)
  if t <= 4
    wandOffset = [t/8; 0.3*sin(2*pi*t/4)];
  elseif t <= 8
    wandOffset = [0.5; (t-4)/8];
  else
    wandOffset = [0.5 - (t - 8) / 4; 0.5 - (t - 8) / 16];
  end
end
