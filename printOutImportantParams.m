function [opts, shape] = printOutImportantParams(opts, shape, clean_terminal)
    if clean_terminal
        clc
    end
    twisted_methods_des = ["random", "descompose", "descomposeNoTrans", "descomposeNoTransScaling"];
    horizontal_lines_methods_des = ["fixedLines", "minMaxRatio", "Iillumination"];
    cost_functions_des = ["sensitivity", "sensitivityPuffiblility", ...
                          "sensitivityPuffibilityRatio", ...
                          "sensitivityPuffibilityRatioEdgeSign"];
    flag = ["No", "Yes"];
    
    disp("============= User settings ================")
    disp("------------------")
    disp("-- Initializations")
    disp("------------------")
    initial_values = makeRow(opts.opt.initial_values)
    twisted_method = twisted_methods_des(opts.opt.twisted_method)
    random_initials = flag(opts.opt.random_initials + 1)
    large_initials = flag(opts.opt.large_initials + 1)
    seed = opts.opt.random_seed;
    
    disp("------------------")
    disp("-- Constraints")
    disp("------------------")
    use_constraints = flag(opts.opt.use_constraints+1)
    convexity_constraints = flag(opts.opt.convexity_constraints+1)
    length_constraints = flag(opts.opt.length_constraints+1)
    
    disp("------------------")
    disp("-- Other")
    disp("------------------")
    rotate_projected = flag(opts.opt.rotate_projected + 1)
    horizontal_lines_method = horizontal_lines_methods_des(opts.opt.ring_method)
    cost_function = cost_functions_des(opts.opt.cost)
    L1_grad = flag(opts.opt.L1_gradient+1)
    spaser_list = linspace(opts.opt.point_per_Ncm/opts.opt.L1_sparse_level, ...
                           opts.opt.point_per_Ncm, opts.opt.L1_sparse_level)
    regulizer = flag(opts.opt.regulizer+1)
    
    % prepare for saving name
    prefix = "";
    
    prefix = "seed" + num2str(seed) + "-";
    
    if opts.opt.large_initials
        prefix = prefix + "lGuess-"; % largeInitialGuess
    else
        prefix = prefix + "sGuess-"; % smallInitialGuess
    end
    
    if opts.opt.convexity_constraints
        prefix = prefix + "Conv-"; % preserveConvexity
    else
        prefix = prefix + "nConv-"; % noPreserveConvexity
    end
    
%     if opts.opt.slope_constraints
%         prefix = prefix + "Slope-"; % slopeConstr
%     else
%         prefix = prefix + "nSlpe-"; % noSlope
%     end
    
    if opts.opt.length_constraints
        prefix = prefix + "length-"; % lengthConstr
    else
        prefix = prefix + "nLength-"; % noLengthConstr
    end
    
    if opts.opt.L1_gradient
        weight = "W" + num2str(opts.opt.L1_gradient_weight,'%10.0e');
        grid_length = "M" + num2str(opts.opt.grid_length,'%10.0e');
        point_per_Ncm = "N" + num2str(opts.opt.point_per_Ncm,'%10.0e');
        L1_sparse_level = "L" + num2str(opts.opt.L1_sparse_level,'%i');
        prefix = prefix + "L1Grad" + weight + grid_length + point_per_Ncm + L1_sparse_level +"-";
    else
        prefix = prefix + "noL1Grad-";
%          prefix = prefix;
    end
    
    if opts.opt.rotate_projected
        prefix = prefix + "rot" + num2str(opts.opt.param_circle)+"-"; % rotation
    else
        prefix = prefix + "noRot-"; % noRotation
    end
    
    if opts.opt.ring_method == 3
        horizontal_lines_method = "R" + num2str(opts.opt.num_ring) +"N" + num2str(opts.opt.illumination_region) + horizontal_lines_method;
    end
    
    if opts.opt.regulizer
        regulizer = "reg-";
    else
        regulizer = "nReg-";
    end
    
    
    saving_name = prefix + horizontal_lines_method + "-"+ regulizer +cost_function
    opts.save_name = saving_name;
    disp("============================================")
end