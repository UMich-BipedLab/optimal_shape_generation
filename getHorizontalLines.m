function [horzontal_lines, num_ring] = getHorizontalLines(opts, sorted_vertices_h)
    if opts.opt.ring_method == 1
        horzontal_lines = opts.opt.line_y;
        num_ring = length(horzontal_lines);
    elseif opts.opt.ring_method == 2 || opts.opt.ring_method == 3
        if ~isfield(opts.opt, 'num_ring')
            opts.opt.num_ring = 4; 
        end
        num_ring = opts.opt.num_ring;
        horzontal_lines = genHorizontalLines(opts, sorted_vertices_h);
    end
end