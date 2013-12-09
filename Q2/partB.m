function [] = partB(IDX25, IDXout25, IDX50, IDXout50, depots, drops, nodes)
  depot_nodes = nodesFromLocations(nodes, depots);
  drop_nodes = nodesFromLocations(nodes, drops);
  connections = makeConnectionMatrix(IDX25, IDXout25, IDX50, IDXout50);

  findPath(connections, depot_nodes(1), drop_nodes(1))
end
