clc, clear, close all
addpath(genpath("./data/"))
addpath(genpath("./paper_results/"))
addpath(genpath("/home/brucebot/workspace/matlab_utils"))
opts.tag_placement_lib = 0;
opts = loadLibraries(2, opts);
[axes_handles, fig_handles] = createFigHandleWithNumber(2, 20,"Convexity");
original_vertices = [0.5         -0.5         -0.5          0.5
                     0.5          0.5         -0.5         -0.5
                     1            1            1            1];


                
                 
projective_matrix1 = [1.707 0.586   1; 
                      2.707 8.242   2;
                      1.1  1.1     1.0];
projective_matrix1 = [1    0    0.1; 
                      0    1   -0.1;
                      3    1    1];   
                  
projective_matrix1 = [1    0    0.1; 
                      0    1   -0.1;
                      2    1    1];                 
                 
condition1 = projective_matrix1(3,1) .* original_vertices(1, :) + ...
     projective_matrix1(3,2) .* original_vertices(2, :) + projective_matrix1(3,3)
projected_vertices1 = projectionMap(original_vertices, projective_matrix1);




[axes_h, fig_h] = getCurrentFigure(1, axes_handles, fig_handles);
cla(axes_h);
h1 = plotShape(axes_h, original_vertices, 'k', 'k');
h2 = plotShape(axes_h, projected_vertices1, 'r', 'r');

% text for nominal target
putText(axes_h, original_vertices(1,1), original_vertices(2, 1), ...
    original_vertices(3,1), "${X}_1$", 'k', 'left')
putText(axes_h, original_vertices(1,2), original_vertices(2, 2), ...
    original_vertices(3,2), "${X}_2$", 'k', 'right')
putText(axes_h, original_vertices(1,3), original_vertices(2, 3), ...
    original_vertices(3,3), "${X}_3$", 'k', 'right')
putText(axes_h, original_vertices(1,4), original_vertices(2, 4), ...
    original_vertices(3,4), "${X}_4$", 'k', 'left')


% text for transformed target
putText(axes_h, projected_vertices1(1,1), projected_vertices1(2, 1), ...
    projected_vertices1(3,1), "$\tilde{X}_1$", 'r', 'left')
putText(axes_h, projected_vertices1(1,2), projected_vertices1(2, 2), ...
    projected_vertices1(3,2), "$\tilde{X}_2$", 'r', 'right')
putText(axes_h, projected_vertices1(1,3), projected_vertices1(2, 3), ...
    projected_vertices1(3,3), "$\tilde{X}_3$", 'r', 'left')
putText(axes_h, projected_vertices1(1,4), projected_vertices1(2, 4), ...
    projected_vertices1(3,4), "$\tilde{X}_4$", 'r', 'left')



viewCurrentPlot(axes_h)
xlim(axes_h, [-0.9, 0.9])
ylim(axes_h, [-0.6, 1.5])
% saveCurrentPlot(fig_h, "non-convex", 'png');
%%
projective_matrix2 = [1 0 0.1; 
                      0 -1 -0.1;
                      2 0.5 2];
                  
projective_matrix2 = [-1    0    0.1; 
                      0    -1   -0.1;
                      1    2    2.2];                  
condition2 = projective_matrix2(3,1) .* original_vertices(1, :) + ...
    projective_matrix2(3,2) .* original_vertices(2, :) + projective_matrix2(3,3)
projected_vertices2 = projectionMap(original_vertices, projective_matrix2);


[axes_h, fig_h] = getCurrentFigure(2, axes_handles, fig_handles);;
cla(axes_h)
h1 = plotShape(axes_h, original_vertices, 'k', 'k');
h2 = plotShape(axes_h, projected_vertices2, 'r', 'r');

% text for nominal target
putText(axes_h, original_vertices(1,1), original_vertices(2, 1), ...
    original_vertices(3,1), "${X}_1$", 'k', 'left')
putText(axes_h, original_vertices(1,2), original_vertices(2, 2), ...
    original_vertices(3,2), "${X}_2$", 'k', 'right')
putText(axes_h, original_vertices(1,3), original_vertices(2, 3), ...
    original_vertices(3,3), "${X}_3$", 'k', 'right')
putText(axes_h, original_vertices(1,4), original_vertices(2, 4), ...
    original_vertices(3,4), "${X}_4$", 'k', 'left')

% text for transformed target
putText(axes_h, projected_vertices2(1,1), projected_vertices2(2, 1), ...
    projected_vertices2(3,1), "$\tilde{X}_1$", 'r', 'right')
putText(axes_h, projected_vertices2(1,2), projected_vertices2(2, 2), ...
    projected_vertices2(3,2), "$\tilde{X}_2$", 'r', 'left')
putText(axes_h, projected_vertices2(1,3), projected_vertices2(2, 3), ...
    projected_vertices2(3,3), "$\tilde{X}_3$", 'r', 'left')
putText(axes_h, projected_vertices2(1,4), projected_vertices2(2, 4), ...
    projected_vertices2(3,4), "$\tilde{X}_4$", 'r', 'right')


viewCurrentPlot(axes_h)
xlim(axes_h, [-0.9, 0.9])
ylim(axes_h, [-0.6, 1.5])
% saveCurrentPlot(fig_h, "convex", 'png');