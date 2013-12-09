function [new_connections] = removePathFromConnections(path, connections)
  new_connections = connections;
  % no other path may enter any of the nodes in this path
  % thay may exit though (to fix depot-leaving issues)
  for i = [1:length(path)]
    for j = [1:length(connections)]
      new_connections(j, path(i)) = 0;
    end
  end
end
