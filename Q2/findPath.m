function [path_nodes] = findPath(connections, start_node, end_node)
  % breadth-first search to the goal
  num_nodes = length(connections);
  explored_nodes = ones(num_nodes) * inf;
  explored_nodes(start_node) = -1;
  prev_explored_nodes = [start_node];

  while explored_nodes(end_node) == inf
    % for each node opened last iteration
    next_explored_nodes = [];
    for expanding_node = prev_explored_nodes
      % for each node that might lead from this one
      for node_to_explore = [1:num_nodes]
        % node_to_explore
        if (not(explored_nodes(node_to_explore) == inf)) || (not(connections(expanding_node, node_to_explore)))
          continue;
        end
        % node_to_explore does lead from expanding_node, and hasn't been explored yet
        explored_nodes(node_to_explore) = expanding_node;
        next_explored_nodes = cat(2, next_explored_nodes, node_to_explore);
      end
    end
    if length(next_explored_nodes) == 0
      'Failed to find a path'
      return;
    end
    prev_explored_nodes = next_explored_nodes;
  end
  % trace the path back
  path_nodes = [end_node];
  while explored_nodes(path_nodes(1)) > 0
    path_nodes = cat(1, explored_nodes(path_nodes(1)), path_nodes);
  end
end
