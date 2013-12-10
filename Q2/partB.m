maps();

depot_nodes = nodesFromLocations(nodes, depots);
drop_nodes = nodesFromLocations(nodes, drops);
connections = makeConnectionMatrix(IDX25, IDXout25, IDX50, IDXout50);

total_flight_time = 0;
color_strings = ['y' 'c' 'r' 'g' 'k' 'y' 'c' 'r' 'g' 'k'];
for depot_idx = [1:2]
  for copter_idx = [(depot_idx-1)*5+1 : depot_idx*5]
    path = findPath(connections, depot_nodes(depot_idx), drop_nodes(copter_idx));
    % 2x flight time for delivery and return
    total_flight_time = total_flight_time + 2 * getFlightTime(path);
    plotPath(path, length(node_locations), node_locations, color_strings(copter_idx));
    % remove that path from the connection matrix
    [connections aquired_connections] = aquirePathFromConnections(path, connections);
  end
end

total_flight_time
