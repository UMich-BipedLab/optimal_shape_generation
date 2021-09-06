function total_cost = computeShapeSensitivity(opts, params, points)  
    projective_matrix = findProjectiveMethod(opts, params);
    distorted_vertice_h = projectionMap(points, projective_matrix); % 3x4 matrix if a quadrilateral
    
    if opts.opt.L1_gradient
        [sorted_vertices, ~, ~] = sortVertices([], distorted_vertice_h);
%         shape_length = max(max(abs(sorted_vertices), [], 1));

        % prepare sparse list
        N = opts.opt.point_per_Ncm;
        M = opts.opt.L1_sparse_level;
        spaser_list = linspace(N/M,N,M);

        grad_score = zeros(1, length(spaser_list));
        for i=1:length(spaser_list)
            num_sample_points = round(opts.opt.grid_length*100/(spaser_list(i)));
            [y,z] = genUniformGrid(num_sample_points, 5);
            testing_h = convertToHomogeneousCoord([zeros(1, size(y, 2)); y; z]);
            sorted_vertices_x = [zeros(1, size(sorted_vertices, 2)); sorted_vertices];
            edge_t = computeEdgeCoefficients(sorted_vertices_x);
            store = struct();
    %         [grad_score, ~] = computeConstraintCustomizedLieGroupOptimalShapeSE3(eye(4), store, testing_h, 0.05, edge_t);
            [grad, ~] = computeEuclideanGradient(eye(4), store, testing_h, 0.05, edge_t);
            grad_score(i) = norm([grad.R, grad.t; 0 0 0 1]);
    %         grad_score = min(1e4, grad_score);
            grad_score(i) = grad_score(i)*opts.opt.L1_gradient_weight;
        end
        fianl_grad_score = mean(grad_score);
    else
        fianl_grad_score = 0;
    end
    
%     projective_matrix * points
    if opts.opt.ring_method == 3
        illumination_region = opts.opt.illumination_region;
    else
        illumination_region = 1;
    end
    
    angle_list = genAngleList(opts);
    num_angs = length(angle_list);
    cost = zeros(num_angs, illumination_region);
    for i = 1:num_angs
        rot_distorted_vertice_h = moveByThetaXY(distorted_vertice_h, angle_list(i), [0 0]);
        for j = 1:illumination_region
            opts.opt.current_ill_region = j;
            [intersection_t, ~, opts.opt.num_ring, opts.opt.sorted_vertices_h] = compute2DIntersectionPoints(opts, rot_distorted_vertice_h);
            [cost(i, j), ~] = computeSensitivity(opts, params, intersection_t);
        end
    end
    total_cost = sum(sum(cost)) - fianl_grad_score;
end