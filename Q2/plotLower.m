figure(2); clf; hold on;
plot([0 X X 0 0], [0 0 Y Y 0], 'b'); % boundary
plot(depots(:,1),depots(:,2), 'ro', 'MarkerSize',6,'LineWidth',2)
plot(drops(:,1),drops(:,2), 'go', 'MarkerSize',6,'LineWidth',2)
plot(nodes(:,1),nodes(:,2), 'm.', 'MarkerSize',2)

for i=1:length(IDX25)
    cur = IDXout25(i);
    for j = 1:length(IDX25{i})
        next = IDXout25(IDX25{i}(j)); 
        plot([nodes(cur,1) nodes(next,1)], [nodes(cur,2) nodes(next,2)], 'm--')
    end
end
axis equal
title('Graph for 25m flight level')
