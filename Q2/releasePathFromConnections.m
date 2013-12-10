function [new_connections] = releasePathFromConnections(path, connections)
  new_connections = connections;
  for i = [1:length(path)-1]
    new_connections(path(i), path(i+1)) = 1;
    new_connections(path(i+1), path(i)) = 1;
  end
end
