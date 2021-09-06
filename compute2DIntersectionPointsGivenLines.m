function intersection_t = compute2DIntersectionPointsGivenLines(sorted_vertices_h, horizontal_lines)
    num_line = length(horizontal_lines); % how many lines
    num_vertices = size(sorted_vertices_h, 2);
    intersection_t(num_line*2) = struct('line', [], 'intersection_point', [], 'vertices', [], 'status', []);

%     [sorted_vertices, indices] = sortrows(vertices_mat_h', 2, 'descend');
%     sorted_vertices = sorted_vertices';
    
    % at most num_line*2 edge points
%     intersection_t(num_line*2) = struct('line', [], 'intersection_point', [], 'vertices', [], 'status', []);
    count = 1;
    for i = 1:num_vertices
        % this vertices
        p1 = sorted_vertices_h(:, i);
        j = max(mod(i+1, num_vertices+1), 1); % next vertices
        p2 = sorted_vertices_h(:, j);
        for line = 1:num_line
            [intersection_point,  status] = compute2DIntersectionPointsGivenHorizontalLines(p1, p2, horizontal_lines(line));
            if status == 0
                warning("horizontal line")
%                 return
            elseif status == 1
                % point is outside of the segement
%                 warning("points are outside of the segment")
            elseif status == 2    
                warning("overlapping intersection pionts with vertices")
            elseif status == 3
                intersection_t(count).line = horizontal_lines(line);
                intersection_t(count).intersection_point = intersection_point;
                intersection_t(count).vertices = [p1, p2];
                intersection_t(count).status = status;
                count = count + 1;
            end
        end
    end
end