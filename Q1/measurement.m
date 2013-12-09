function [measureX measureY] = measurement(realX, realY)
  measureX = realX + normrnd(0, sqrt(0.0001));
  measureY = realY + normrnd(0, sqrt(0.0001));
end
  
