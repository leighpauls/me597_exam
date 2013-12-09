maps();

depot_nodes = nodesFromLocations(nodes, depots);
drop_nodes = nodesFromLocations(nodes, drops);
connections = makeConnectionMatrix(IDX25, IDXout25, IDX50, IDXout50);

color_strings = ['y' 'c' 'r' 'g' 'k' 'y' 'c' 'r' 'g' 'k'];
for depot_idx = [1:2]
  for copter_idx = [(depot_idx-1)*5+1 : depot_idx*5]
    path = findPath(connections, depot_nodes(depot_idx), drop_nodes(copter_idx));
    plotPath(path, length(connections)/2, node_locations, color_strings(copter_idx));
    % remove that path from the connection matrix
    connections = removePathFromConnections(path, connections);
  end
end

