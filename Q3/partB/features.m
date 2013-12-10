%% Features.m map for Question 3 - FastSLAM with bad correspondences

% Measurement model
rmax = 15;
thmax = pi/3;

% Annulus Feature Map
M1 = 30;
samples1 = rand(2,M1);
r1 = 4*samples1(1,:)+ 10;
ang1 = 2*pi*samples1(2,:);
M2 = 8;
samples2 = rand(2,M2);
r2 = 4*samples2(1,:);
ang2 = 2*pi*samples2(2,:);
map = [r1.*cos(ang1), (r2).*cos(ang2);r1.*sin(ang1), (r2).*sin(ang2)];
map(1,:) = map(1,:); 
map(2,:) = map(2,:)+5; 
plot(map(1,:),map(2,:),'bo')
M = M1+M2;

figure(1);clf; hold on;
cmap = colormap('jet');
cmap = cmap(1:3:end,:);
cn = length(cmap(:,1));
for j = 1:M
    plot(map(1,j),map(2,j),'o','Color', cmap(mod(j,cn)+1,:), 'MarkerSize',10,'LineWidth',2);
end
