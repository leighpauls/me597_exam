maps();

depot_nodes = nodesFromLocations(nodes, depots);
drop_nodes = nodesFromLocations(nodes, drops);
connections = makeConnectionMatrix(IDX25, IDXout25, IDX50, IDXout50);
color_strings = ['y' 'c' 'r' 'g' 'k' 'y' 'c' 'r' 'g' 'k'];

% build the future deliveries
future_deliveries = [];
for delivery_idx = [1:length(drop_nodes)]
  entry = struct;
  entry.delivery_idx = delivery_idx;
  entry.start_time = delivery_idx*5;
  entry.depot_idx = 2 - mod(delivery_idx, 2);
  entry.drop_idx = delivery_idx;
  entry.color = color_strings(delivery_idx);
  future_deliveries = cat(1, future_deliveries, entry);
end

deliveries_in_flight = [];
% returns_in_flight entry: delivery_idx, end_time, depot_idx, drop_idx, color
returns_in_flight = [];

cur_time = 0;

while length(future_deliveries) > 0 || length(deliveries_in_flight) > 0 || length(returns_in_flight) > 0
  % check for new deliveries
  i = 1;
  while i <= length(future_deliveries)
    delivery = future_deliveries(i);
    if cur_time >= delivery.start_time
      path = findPath(connections, depot_nodes(delivery.depot_idx), drop_nodes(delivery.drop_idx));
      plotPath(path, length(node_locations), node_locations, delivery.color);
      [connections aquired_connections] = aquirePathFromConnections(path, connections);
      flight_time = getFlightTime(path);
      
      % create a delivery in flight
      in_flight = rmfield(delivery, 'start_time');
      in_flight.end_time = delivery.start_time + flight_time;
      in_flight.aquired_connections = aquired_connections;

      % add the new delivery flight
      deliveries_in_flight = cat(1, deliveries_in_flight, in_flight);

      % remove the future delivery from the futures list
      future_deliveries = cat(1, future_deliveries(1:i-1), future_deliveries(i+1:length(future_deliveries)));
    else
      i = i + 1;
    end
  end

  % check for finished deliveries
  i = 1;
  while i <= length(deliveries_in_flight)
    delivery = deliveries_in_flight(i);
    if cur_time >= delivery.end_time
      % release the path
      connections = releasePathFromConnections(delivery.aquired_connections, connections);
      % make a new path home
      path = findPath(connections, drop_nodes(delivery.drop_idx), depot_nodes(delivery.depot_idx));
      plotPath(path, length(node_locations), node_locations, delivery.color);
      [connections aquired_connections] = aquirePathFromConnections(path, connections);
      flight_time = getFlightTime(path);

      return_flight = delivery;
      return_flight.end_time = cur_time + flight_time;
      return_flight.aquired_connections = aquired_connections;
      
      % add the new return flight
      returns_in_flight = cat(1, returns_in_flight, return_flight);
      
      % remove the delivery from the deliveries list
      deliveries_in_flight = cat(1, deliveries_in_flight(1:i-1), deliveries_in_flight(i+1:length(deliveries_in_flight)));
    else
      i = i + 1;
    end
  end

  % check for finished returns
  i = 1;
  while i <= length(returns_in_flight)
    delivery = returns_in_flight(i);
    if cur_time >= delivery.end_time
       % release the path
       connections = releasePathFromConnections(delivery.aquired_connections, connections);
       % remove it from the returns list
       returns_in_flight = cat(1, returns_in_flight(1:i-1), returns_in_flight(i+1:length(returns_in_flight)));
    else
      i = i + 1;
    end
  end

  cur_time = cur_time + 1;
end
