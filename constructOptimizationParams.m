function [params, num_parameters, initial_values, seed_t] = constructOptimizationParams(opts, t_initial_values, seed)
%     rng(2);
%     rng(152);
%     seed = rng;
    if exist('seed', 'var') && ~isempty(seed) && ~isnumeric(seed)
        rng(seed);
    elseif isnumeric(seed)
        rng(seed);
        seed_t = rng;
    else
        rng(2);
        seed_t = rng;
    end
    
    lower_bound = 0;
    upper_bound = 100;
    if opts.opt.twisted_method == 1 || opts.opt.twisted_method == 2
        num_parameters = 8;
    elseif opts.opt.twisted_method == 3
        num_parameters = 6;
    elseif opts.opt.twisted_method == 4
        num_parameters = 5;
    end
    
    params = optimvar('params', 1, num_parameters, 'LowerBound', lower_bound,'UpperBound', upper_bound);

    if opts.opt.random_initials == 1
        if opts.opt.large_initials
            initial_values = genRandomNumber(lower_bound, upper_bound, seed_t, num_parameters);
        else
            initial_values = rand(1, num_parameters);
        end
    elseif opts.opt.random_initials == 2
         initial_values = ones(1, num_parameters);
    else
        if length(t_initial_values) == num_parameters
            initial_values = t_initial_values;
        else
            fprintf("number of given initail value: %i, which should be %i", length(t_initial_values), num_parameters)
            error("Wrong number of initial values, please check")
        end    
    end
end