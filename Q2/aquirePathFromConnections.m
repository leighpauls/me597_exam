function [new_connections aquired_connections] = aquirePathFromConnections(path, connections)
  new_connections = connections;
  aquired_connections = [];
  for i = [1:length(path)-1]
    aquired_connections = cat(1, aquired_connections, [path(i), path(i+1); path(i+1), path(i)]);
    new_connections(path(i), path(i+1)) = 0;
    new_connections(path(i+1), path(i)) = 0;
  end
end
