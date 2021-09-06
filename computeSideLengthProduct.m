function product = computeSideLengthProduct(sorted_vertices_h)
    num_vertices = size(sorted_vertices_h, 2);
    product = 1;
    for i = 1:num_vertices
        i;
        vertex_1 = sorted_vertices_h(1:2, i);
        j = max(mod(i+1, num_vertices+1), 1);
        vertex_2 = sorted_vertices_h(1:2, j);
        side_length = norm(vertex_1 - vertex_2);
        product = product * (side_length);
    end
end