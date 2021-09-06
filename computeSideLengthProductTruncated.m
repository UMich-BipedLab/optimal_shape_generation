function product = computeSideLengthProductTruncated(sorted_vertices_h)
    num_vertices = size(sorted_vertices_h, 2);
    product = 1;
    f_edge_too_long = 0;
    for i = 1:num_vertices
        i;
        vertex_1 = sorted_vertices_h(1:2, i);
        j = max(mod(i+1, num_vertices+1), 1);
        vertex_2 = sorted_vertices_h(1:2, j);
        side_length = norm(vertex_1 - vertex_2);
        if side_length > 2
            f_edge_too_long = 1;
            break
        else
            f_edge_too_long;
        end
        product = product * (side_length);
    end
    if f_edge_too_long
        product = -1;
    else
        product = 1;
    end
end