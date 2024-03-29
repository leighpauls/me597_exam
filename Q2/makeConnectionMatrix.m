function [connectionMatrix] = makeConnectionMatrix(IDX25, IDXout25, IDX50, IDXout50)
  upperPlaneConnections = {};
  for i = [1:length(IDXout50)]
      sourceIdx = IDXout50(i);
      upperPlaneConnections{sourceIdx} = IDX50{i};
      for j = [1:length(upperPlaneConnections{sourceIdx})]
        upperPlaneConnections{sourceIdx}(j) = IDXout50(upperPlaneConnections{sourceIdx}(j));
      end
  end

  connections = {};
  % increase the index of the upper plane so not to conflict with the lower plane
  numNodes = length(upperPlaneConnections);
  for i = [1:length(upperPlaneConnections)]
    connections{i+numNodes} = upperPlaneConnections{i} + numNodes;
  end
  
  for i = [1:length(IDXout25)]
      sourceIdx = IDXout25(i);
      connections{sourceIdx} = IDX25{i};
      for j = [1:length(connections{sourceIdx})]
        connections{sourceIdx}(j) = IDXout25(connections{sourceIdx}(j));
      end
      % all lower plane nodes are connected upwards
      connections{sourceIdx} = cat(2, connections{sourceIdx}, sourceIdx + numNodes);
      connections{sourceIdx + numNodes} = cat(2, connections{sourceIdx + numNodes}, sourceIdx);
  end

  connectionMatrix = zeros(numNodes*2, numNodes*2);
  for sourceIdx = [1:length(connections)]
    for destIdx = connections{sourceIdx};
      connectionMatrix(sourceIdx, destIdx) = 1;
    end
  end
end
