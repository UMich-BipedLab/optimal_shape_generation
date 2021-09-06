function projective_matrix = decomposeProjectiveMatrixFromParams(opts, params)
%% With Scaling
%     s = params(1);
%     theta = params(2);
%     shear_k = params(3);
%     scale_x = params(4);
%     elation_v1 = params(5);
%     elation_v2 = params(6);
%     
%     if opts.opt.twisted_method == 2
%         tx = params(7);
%         ty = params(8);
%     elseif opts.opt.twisted_method == 3
%         tx = 0; 
%         ty = 0; 
%     end
    
%% Without Scaling
    theta = params(1);
    shear_k = params(2);
    scale_x = params(3);
    elation_v1 = params(4);
    elation_v2 = params(5);
    
    if opts.opt.twisted_method == 2
        s = params(6);
        tx = params(7);
        ty = params(8);
    elseif opts.opt.twisted_method == 3
        s = params(6);
        tx = 0; 
        ty = 0; 
    elseif opts.opt.twisted_method == 4
        s = 1;
        tx = 0; 
        ty = 0; 
    end
    projective_matrix = computetDecomposedProjectiveMatrix(s, theta, tx, ty, shear_k, scale_x, elation_v1, elation_v2);
end