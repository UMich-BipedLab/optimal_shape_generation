function shape = computeHeightWidthAnglesLengthOfQuadrilateral(vertices_unsorted, legth_conversion)
    shape.unsorted_mat = vertices_unsorted;
    vertices = sortVertices([], vertices_unsorted);
    shape.sorted_vertices = vertices;
    shape.height = (max(vertices(3,:)) - min(vertices(3,:))) * legth_conversion;
    shape.width = (max(vertices(2,:)) - min(vertices(2,:))) * legth_conversion;

    cur_points = [1, 2];
    shape.d1 = norm(vertices(:, cur_points(1)) - vertices(:, cur_points(2))) * legth_conversion;
    shape.d1_points = cur_points;
    shape.d1_mean =  mean(vertices(:, cur_points), 2);
    
    cur_angle = [1, 2, 4];
    v1 = vertices(2:3, cur_angle(2)) - vertices(2:3, cur_angle(1));
    v2 = vertices(2:3, cur_angle(3)) - vertices(2:3, cur_angle(1));
    shape.ang1 = acosd( dot(v1, v2)/(norm(v1)*norm(v2)) );
    shape.ang1_angles = cur_angle;

    
    cur_points = [2, 3];
    shape.d2 = norm(vertices(:, cur_points(1)) - vertices(:, cur_points(2))) * legth_conversion;
    shape.d2_points = cur_points;
    shape.d2_mean =  mean(vertices(:, cur_points), 2);
    cur_angle = [2, 1, 3];
    v1 = vertices(2:3, cur_angle(2)) - vertices(2:3, cur_angle(1));
    v2 = vertices(2:3, cur_angle(3)) - vertices(2:3, cur_angle(1));
    shape.ang2 = acosd( dot(v1, v2)/(norm(v1)*norm(v2)) );
    shape.ang2_angles = cur_angle;

    
    cur_points = [3, 4];
    shape.d3 = norm(vertices(:, cur_points(1)) - vertices(:, cur_points(2))) * legth_conversion;
    shape.d3_points = cur_points;
    shape.d3_mean =  mean(vertices(:, cur_points), 2);
    cur_angle = [3, 2, 4];
    v1 = vertices(2:3, cur_angle(2)) - vertices(2:3, cur_angle(1));
    v2 = vertices(2:3, cur_angle(3)) - vertices(2:3, cur_angle(1));
    shape.ang3 = acosd( dot(v1, v2)/(norm(v1)*norm(v2)) );
    shape.ang3_angles = cur_angle;


    cur_points = [4, 1];
    shape.d4 = norm(vertices(:, cur_points(1)) - vertices(:, cur_points(2))) * legth_conversion;
    shape.d4_points = cur_points;
    shape.d4_mean =  mean(vertices(:, cur_points), 2);
    cur_angle = [4, 3, 1];
    v1 = vertices(2:3, cur_angle(2)) - vertices(2:3, cur_angle(1));
    v2 = vertices(2:3, cur_angle(3)) - vertices(2:3, cur_angle(1));
    shape.ang4 = acosd( dot(v1, v2)/(norm(v1)*norm(v2)) );
    shape.ang4_angles = cur_angle;
end