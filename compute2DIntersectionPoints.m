function [intersection_t, horzontal_lines, num_ring, sorted_vertices_h] = compute2DIntersectionPoints(opts, dis_vertices_mat_h)
    colinear = checkColinear(dis_vertices_mat_h);
    if colinear
        intersection_t = struct('line', [], 'intersection_point', [], 'vertices', [], 'status', []);
        horzontal_lines = [];
        num_ring = 4; % any positive number, we use the default value
        sorted_vertices_h = [];
    else
        % Should be convex already. 
        % This is only sort for counterclockwise
        [indices, dis_area] = convhull(dis_vertices_mat_h(1,:), dis_vertices_mat_h(2,:));
        
        % scaling area to one
        cor_dis_vertices_mat_2d_h = sqrt(1/dis_area) * dis_vertices_mat_h(1:2, :);
        sorted_vertices_h = [cor_dis_vertices_mat_2d_h(:, indices(1:end-1)); ones(1, length(indices)-1)];
        [horzontal_lines, num_ring] = getHorizontalLines(opts, sorted_vertices_h);
        intersection_t = compute2DIntersectionPointsGivenLines(sorted_vertices_h, horzontal_lines);
    end
end