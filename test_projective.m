clc, clear
addpath("/home/brucebot/workspace/matlab_utils/general")
opts.tag_placement_lib = 0;
loadLibraries(2, opts);

shape = 4;
vertices = genShape([], 1, shape);
vertices_mat = convertXYZstructToXYZmatrix(vertices);
org_area = polyarea(vertices.y, vertices.z)
vertices_mat_2d_h = [vertices_mat(2:3, :); ones(1, shape)];

%
opts.opt.line_y = [-0.4, -0.2, 0.1, 0.3];

% figure handles

    
for i = 1:1
%     rng(1);
    params = rand(1,8);
    s = params(1);
    theta = params(2);
    tx = 0; % params(3);
    ty = 0; % params(4);
    k = params(5);
    lambda = params(6);
    v1 = params(7);
    v2 = params(8);
    sim = [s*cos(theta) -s*sin(theta) tx;
           s*sin(theta) s*cos(theta) ty;
           0 0 1];
    shear = eye(3);
    shear(1, 2) = k;
    scaling = eye(3);
    scaling(1, 1) = lambda;
    scaling(2, 2) = 1/lambda;
    elation = eye(3);
    elation(3, 1) = v1;
    elation(3, 2) = v2;
    projective_matrix = sim*shear*scaling*elation;
    dis_vertices_mat_2d_h = projective_matrix * vertices_mat_2d_h;
    dis_vertices_mat_2d_h = dis_vertices_mat_2d_h./dis_vertices_mat_2d_h(3,:);

    

%     projective_matrix = rand(3, 3);
%     projective(3, 3) = 1;

    
    
    dis_vertices_mat_2d_h = projectionMap(vertices_mat_2d_h, projective_matrix)
    
    [dis_k, dis_area] = convhull(dis_vertices_mat_2d_h(1,:), dis_vertices_mat_2d_h(2,:));

    % scaling area to one
    cor_dis_vertices_mat_2d_h = sqrt(1/dis_area) * dis_vertices_mat_2d_h(1:2, :);
    [cor_k, cor_area] = convhull(cor_dis_vertices_mat_2d_h(1,:), cor_dis_vertices_mat_2d_h(2,:));
    
    % convert back to 3d
    dis_vertices_mat_3d_h = [zeros(1, shape); dis_vertices_mat_2d_h];
    dis_vertices = convertXYZmatrixToXYZstruct(dis_vertices_mat_3d_h);
 
    cor_dis_vertices_mat_3d_h = [zeros(1, shape); cor_dis_vertices_mat_2d_h];
    cor_dis_vertices = convertXYZmatrixToXYZstruct(cor_dis_vertices_mat_3d_h);
        
    %% Plottings
    fig_hangles = createFigHandleWithNumber(1, 10, "projective");
    fig = fig_hangles(1);
    cleanCurrentPlot(fig, 0);
    plotConnectedVerticesStructure(fig, vertices, 'k')
    plotConnectedVerticesStructure(fig, dis_vertices, 'b')
    plotConnectedVerticesStructure(fig, cor_dis_vertices, 'r')
    drawnow
    viewCurrentPlot(fig, "original shape", [-90, 0])
        
    %%6
    opts.opt.ring_method = 2;
    opts.opt.num_ring = 4; 
    [intersection_t, horzontal_lines, num_ring, opts.opt.sorted_vertices_h] = compute2DIntersectionPoints(opts, dis_vertices_mat_2d_h);
    intersection_points = [intersection_t(:).intersection_point];
    opts.opt.param_se2 = 25;
    opts.opt.regulizer = 0;
    computeSensitivity(opts, [], intersection_t)
%     intersection_t(7).intersection_point(1) - intersection_t(7).vertices(1,1)
    if ~isempty(intersection_points)
        scatter3(fig, zeros(1, length(intersection_points)), intersection_points(1, :), intersection_points(2, :), 'fill')
    end

%     plotConnectedVerticesStructure(fig, dis_vertices2)
    viewCurrentPlot(fig, "Show intersetsectoin points", [-90, 0])
    drawnow
%     pause
end
disp("done")

