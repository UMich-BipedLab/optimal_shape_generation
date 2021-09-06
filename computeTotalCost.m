function total_cost = computeTotalCost(opts, se2_1, se2_2, puffibility, ratio)
%% Chosen costs
    if opts.opt.cost == 1
        % Sensitivity only
        total_cost = (norm(se2_1)^2 + norm(se2_2)^2);
    elseif opts.opt.cost == 2
        % Sensitivity with puffibility
        total_cost = (norm(se2_1)^2 + norm(se2_2)^2) * puffibility;
    elseif opts.opt.cost == 3 || opts.opt.cost == 4
        % Sensitivity, puffiblility, ratio)
        total_cost = (norm(se2_1)^2 + norm(se2_2)^2) * ratio + 1e-3*puffibility;
%         total_cost = (norm(se2_1)^2 + norm(se2_2)^2) * ratio + 1000*puffibility;
    else
        error("Cost not supported")
    end
    
    %% Testing costs
%     total_cost = (norm(se2_1)^2 + norm(se2_2)^2) + 1e5*puffibility;
%     total_cost = (norm(se2_1)^2 + norm(se2_2)^2) * ratio + puffibility;
%     total_cost = (norm(se2_1)^2 + norm(se2_2)^2) * ratio;
%     total_cost = (norm(se2_1)^2 + norm(se2_2)^2) + 1e-5 * ratio + 5*puffibility;
end