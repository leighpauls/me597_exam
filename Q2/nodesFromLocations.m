function [position_nodes] = nodesFromLocations(node_list, location_list)
  position_nodes = [];
  for i = [1:length(node_list)]
    node_position = node_list(i,:);
    for j = [1:length(location_list)]
      if isequal(node_position, location_list(j,:))
        position_nodes = cat(1, position_nodes, i);
      end
    end
  end
end
