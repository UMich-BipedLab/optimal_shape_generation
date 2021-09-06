function total_score = computeSensitivityCost(opts, intersection_t, omega, v, u)
    if isempty([intersection_t.intersection_point])
        total_score = 1e-5;
        return
    end
        
    horzontal_lines = findDuplicatedOnce([intersection_t(:).line], 1);
    num_lines = length(horzontal_lines);
%     if num_lines == 0
%     if num_lines ~= opts.opt.num_ring
%         total_score = -1e5;
%         return
%     end
    
    % if intersection point lies on a vertices
%     intersection_points = [intersection_t(:).intersection_point];
%     vertices = opts.opt.sorted_vertices_h(1:2, :);
%     indices = ismembertol(vertices, intersection_points, 5e-2);
%     if any(all(indices))
%         total_score = -1e5;
%         return
%     end    
    sorted_vertices_h = opts.opt.sorted_vertices_h(1:2, :);
    if opts.opt.cost == 1 ||  opts.opt.cost == 2 || opts.opt.cost == 3
        product = 1;
    elseif opts.opt.cost == 4
        product = computeSideLengthProductTruncated(sorted_vertices_h);
    end
    num_points = size(intersection_t, 2);
    score(num_lines) = struct('se2_1', [], 'se2_2', [], 'ratio', [], 'puffibility', [], 'total', []);
    count = 1;
    
    for line = num_lines:-1:1
        current_line = horzontal_lines(line);
        edge_indices = find(current_line==[intersection_t(:).line], num_points);
        num_indices = length(edge_indices);
        
        if num_indices == 2
            % compute se2 lost (first edge point)
            currnt_indx = edge_indices(1);
            p1 = intersection_t(currnt_indx).vertices(:, 1);
            p2 = intersection_t(currnt_indx).vertices(:, 2);
            edge_point1 = intersection_t(currnt_indx).intersection_point;
            score(count).se2_1 = computese2Cost(edge_point1, p1, p2, omega, v, u);
            
            % compute se2 lost (second edge point)
            currnt_indx = edge_indices(2);
            p3 = intersection_t(currnt_indx).vertices(:, 1);
            p4 = intersection_t(currnt_indx).vertices(:, 2);
            edge_point2 = intersection_t(currnt_indx).intersection_point;
            score(count).se2_2 = computese2Cost(edge_point2, p3, p4, omega, v, u);
            
            % height/width ratio of the current polygon
            score(count).ratio = computeHeightWidthRatio(p1, p2, p3, p4);
            
            % distance of p1p2, p3p4
%             score(count).ratio = norm(p1- p2) * norm(p3 - p4);
            
            % compute puffibility lost
            score(count).puffibility = computePuffibility(edge_point1, edge_point2);
            score(count).total = computeTotalCost(opts, score(count).se2_1, score(count).se2_2, score(count).puffibility, score(count).ratio);
            count = count + 1; 
        else
%             if num_indices ~= 0
%                 num_indices
%                 error("shape none-convex")
%             end
        end
    end
%     total_score = -min([score(:).total]);
%     cost = min([score(:).total]);
    total_score = sum([score(:).total]) * product;
end