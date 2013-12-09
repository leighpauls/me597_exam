function [] = plotPath(path, upper_plane_idx, node_locations, color_string)
  % copters all start on the lower level
  on_upper = false;
  figure(2);
  for i = [1:length(path)-1]
    cur_node = path(i);
    next_node = path(1+i);
    if on_upper && next_node < upper_plane_idx
      pos = node_locations(next_node, :);
      scatter(pos(1), pos(2), color_string);
      on_upper = false;
      figure(2);
      scatter(pos(1), pos(2), color_string);
    elseif ((not(on_upper)) && (next_node >= upper_plane_idx))
      pos = node_locations(cur_node, :);
      scatter(pos(1), pos(2), color_string);
      on_upper = true;
      figure(3);
      scatter(pos(1), pos(2), color_string);
    else
      if cur_node >= upper_plane_idx
        start_pos = node_locations(cur_node - upper_plane_idx, :);
        end_pos = node_locations(next_node - upper_plane_idx, :);
      else
        start_pos = node_locations(cur_node, :);
        end_pos = node_locations(next_node, :);
      end
      plot([start_pos(1), end_pos(1)], [start_pos(2), end_pos(2)], color_string);
    end
  end
end
