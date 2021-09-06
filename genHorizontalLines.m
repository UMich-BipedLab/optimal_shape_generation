function horzontal_lines = genHorizontalLines(opts, dis_vertices_mat_h)
    num_rings = opts.opt.num_ring;
    max_y = max(dis_vertices_mat_h(2, :));
    min_y = min(dis_vertices_mat_h(2, :));
    height = max_y - min_y;
    
    if opts.opt.ring_method == 2
        % equally spread across the targe
        delta_height = height/(num_rings+1);
        low_bound = min_y;
    elseif opts.opt.ring_method == 3
        % Example: 
        %       opts.opt.num_ring = 3;
        %       opts.opt.illumination_region = 2
        %       N = current illumination area
        %       delta_height = gap / (num_rings+1);
        % ============================= max_y
        %        ^      ^ ------------- low_bound + 3 * delta_height
        %        |  gap | ------------- low_bound + 2 * delta_height
        %        |      v ------------- low_bound + 1 * delta_height
        % height |===================== low_bound = min_y + (N-1) * gap
        %        |  -------------------
        %        |  -------------------
        %        v  -------------------
        % ============================= min_y = low_bound = min_y + (N-1) * gap
        gap = height / opts.opt.illumination_region;
        delta_height = gap / (num_rings+1);
        low_bound = min_y + (opts.opt.current_ill_region-1) * gap;
    end
    
    horzontal_lines = zeros(1, num_rings);
    for i = 1:num_rings
        horzontal_lines(i) = low_bound + i*delta_height;
    end
end