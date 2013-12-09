function [new_connections] = removePathFromConnections(path, connections)
  new_connections = connections;
  for i = [1:length(path)-1]
    new_connections(path(i), path(i+1)) = 0;
    new_connections(path(i+1), path(i)) = 0;
  end
end
