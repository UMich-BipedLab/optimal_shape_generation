clc
addpath(genpath("/home/brucebot/workspace/matlab_utils"))
opts.tag_placement_lib = 0;
opts = loadLibraries(2, opts);
axes_figs = createFigHandleWithNumber(2, 20,"Convexity");
original_vertices = [0.5         -0.5         -0.5          0.5
                     0.5          0.5         -0.5         -0.5
                     1            1            1            1];


                
                 
projective_matrix = [1.707 0.586 1; 
                     2.707 8.242 2;
                     1.0 2.0 1.0];
projective_matrix = [1 0 0.1; 
                     0 1 -0.1;
                     2 1 1];
% projective_matrix = [       1.2512      0.41119            0
%       0.20265      0.86584            0
%        2.2045      0.87233            1];                 
projected_vertices = projectionMap(original_vertices, projective_matrix);

cur_axes = axes_figs(1);
hold(cur_axes, 'on')
axis(cur_axes, 'equal')
color_list = getColors(4);
plotConnectedVerticesStructure(cur_axes, convertXYZmatrixToXYZstruct(original_vertices), 'k');
plotConnectedVerticesStructure(cur_axes, convertXYZmatrixToXYZstruct(projected_vertices), 'k');
for i = 1:4
    scatter(cur_axes, original_vertices(1,i), original_vertices(2,i), 'fill', 'o','MarkerEdgeColor', color_list{i}, 'MarkerFaceColor', color_list{i})
    scatter(cur_axes, projected_vertices(1,i), projected_vertices(2,i), "*",'MarkerEdgeColor', color_list{i})
end
viewCurrentPlot(cur_axes)


original_vertices2 = [0         1         1         0
                      0         0         1         1
                      1         1         1         1];
projected_vertices2 = projectionMap(original_vertices2, projective_matrix);
cur_axes = axes_figs(2);
% hold(cur_axes, 'on')
% axis(cur_axes, 'equal')
plotConnectedVerticesStructure(cur_axes, convertXYZmatrixToXYZstruct(original_vertices2), 'k');
plotConnectedVerticesStructure(cur_axes, convertXYZmatrixToXYZstruct(projected_vertices2), 'k');
for i = 1:4
    scatter(cur_axes, original_vertices2(1,i), original_vertices2(2,i), 'fill', 'o','MarkerEdgeColor', color_list{i}, 'MarkerFaceColor', color_list{i})
    scatter(cur_axes, projected_vertices2(1,i), projected_vertices2(2,i), "*",'MarkerEdgeColor', color_list{i})
end
viewCurrentPlot(cur_axes)