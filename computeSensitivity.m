function [S, S_test] = computeSensitivity(opts, params, intersection_t)
    num_angles = opts.opt.param_se2; % The number of test points
    ell = 1;

    % This will paramaterize S^2\subset \se_2 for motions
    theta = linspace(0, pi, num_angles);
    phi = linspace(0, 2*pi, num_angles);
    S_test = zeros(num_angles, num_angles);

    for i = 1:num_angles
        for j = 1:num_angles
            omega = sin(theta(i))*cos(phi(j));
            v = sin(theta(i))*sin(phi(j));
            u = cos(theta(i));
            S_test(i,j) = computeSensitivityCost(opts, intersection_t, omega, v, u);
            if opts.opt.regulizer && isempty(params)
                S_test(i,j) = S_test(i,j) + opts.opt.regulizer_ratio * norm(params)^2;
            end
        end
    end

%     S = min(min(S_test)); % The worst of the worst
    S = -min(min(S_test)); % The worst of the worst
end