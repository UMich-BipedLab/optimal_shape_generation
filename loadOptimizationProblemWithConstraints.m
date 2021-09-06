function prob = loadOptimizationProblemWithConstraints(opts, shape, params)
    prob = optimproblem;
    
    if opts.opt.use_constraints
        if opts.opt.twisted_method == 1
    %     prob.Constraints.c1 = rank(reshape([params 1], [3 3])) == 3;
        elseif opts.opt.twisted_method == 2 || opts.opt.twisted_method == 3 || opts.opt.twisted_method == 4
            projective_matrix = findProjectiveMethod(opts, params);
            projected_points = projective_matrix * shape.vertices_mat_2d_h;
            
            if opts.opt.convexity_constraints
                prob.Constraints.presereve_convexity = projected_points(3, :) >= 1;
            end
%             if opts.opt.convexity_constraints
%                 num_vertices = size(shape.vertices_mat_2d_h, 2);
%                 convexity_constraints = optimconstr(1, num_vertices);
%                 
%                 for i = 1:num_vertices
%                     convexity_constraints(i) = projected_points(3, i) >= 1e-10;
%                 end
%                 prob.Constraints.convexity_constraints = convexity_constraints;
%             end
            
%             if opts.opt.slope_constraints
%                 [sorted_vertices] = sortVertices([], projected_points);
% %                 prob.Constraints.
% %                 prob.Constraints.
% %                 prob.Constraints.
% %                 prob.Constraints.
%             end
            
            if opts.opt.length_constraints
                num_vertices = size(shape.vertices_mat_2d_h, 2);
                for i = 1:num_vertices
                    projected_points(:, i) = projected_points(:, i) ./ projected_points(3, i);
                end

                num_length_constrs = nchoosek(num_vertices, 2);
                indices = nchoosek(linspace(1, num_vertices, num_vertices), 2);
                length_constr = optimconstr(2*num_length_constrs, 1);
                for i = 1:2:num_length_constrs
                    p1 = projected_points(:, indices(i, 1));
                    p2 = projected_points(:, indices(i, 2));
                    dist = sqrt((p1(1) - p2(1))^2 + (p1(2) - p2(2))^2);
                    length_constr(i) =  shape.length/10 <= dist;
                    length_constr(i+1) =  dist <= 3*shape.length;
                end
                prob.Constraints.length_constraints = length_constr;
            end
        end
    end
end
