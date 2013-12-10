function [flightTime] = getFlightTime(path)
  % 1 minute for each connection in the path, plus 2 minutes to ascend/descend from the ground
  flightTime = length(path) - 1 + 1;
end
