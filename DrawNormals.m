% quiver3(vertex(1,:),vertex(2,:),vertex(3,:),Normal(1,:),Normal(2,:),Normal(3,:), 1);

close all
load featurelist
load featurelistsym
load meshFace

figure,plot_mesh(vertex, faces);
hold on;
for i = 1:numel(featurelist)
    feat = featurelist{i};
    vertex = feat.kpcoordinates;
    orientation = feat.orientation;
    plot3(vertex(1), vertex(2), vertex(3), 'og', 'MarkerSize', 2, 'MarkerFaceColor', 'g');
    quiver3(vertex(1), vertex(2), vertex(3), orientation(1),orientation(2),orientation(3), 10);
end