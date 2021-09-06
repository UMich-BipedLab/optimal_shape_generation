function projective_matrix = findProjectiveMethod(opts, params)
    if opts.opt.twisted_method == 1
        projective_matrix = reshape([params 1], [3 3])';
    elseif opts.opt.twisted_method == 2 || opts.opt.twisted_method == 3 || opts.opt.twisted_method == 4
        projective_matrix = decomposeProjectiveMatrixFromParams(opts, params);
    end    
end