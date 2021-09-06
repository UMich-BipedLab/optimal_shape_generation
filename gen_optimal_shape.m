clc, clear
addpath(genpath("/home/brucebot/workspace/matlab_utils"))
opts.tag_placement_lib = 0;
% opts = loadLibraries(2, opts);
% addpath('/home/brucebot/workspace/lc-calibration/L1_relaxation')
opt_algorithms = ["interior-point", "trust-region-reflective", ...
                  "sqp", "sqp-legacy", "active-set"];
% load('seed.mat')
% 0: no loading
% 1: loading by given filename
% 2: loading by given user settings
load_saved_settings = 0;
skip_optimization = 0; % directly show saved results

opts.save_numerical_results = 0;
opts.save_graphics_results = 0;
opts.path.saving_folder = "/loadable_results/convexity-NoTNoS-L1GradSparse/small-initial-guess/";
opts.path.loading_folder = "/loadable_results/convexity-NoTNoS/small-initial-guess/";
checkDirectory(string(pwd) + "/" + opts.path.saving_folder, 1);


opts.load_name = "seed2-sGuess-Conv-nLength-rot6-R4N5Iillumination-nReg-sensitivityPuffibilityRatio.mat";

%% optimization settings
if load_saved_settings == 1
    load_path = opts.path.current_path + opts.path.loading_folder;
    load_name = opts.load_name;
    disp("========================")
    fprintf("Loading from %s\n", load_name)
    disp("========================")
    load(load_path + load_name);
    opts = results.opts;
    shape = results.shape;
    opts.save_numerical_results = 0;
    [params, opts.opt.num_parameters, opts.opt.initial_values, opts.seed] = constructOptimizationParams(opts, opts.inial_guess, opts.seed);
elseif load_saved_settings == 0 || load_saved_settings == 2
    [opts, shape, params] = loadUserDefinedSettings(opts);
    if load_saved_settings == 2
        load_path = opts.path.current_path + opts.path.loading_folder;
        load_name = opts.save_name;
        load(load_path + load_name)
        [opts, shape] = printOutImportantParams(opts, shape, 1);
    end
end

prob = loadOptimizationProblemWithConstraints(opts, shape, params);

%% optimization problem
if ~skip_optimization || ~load_saved_settings
    disp("============== Optimizing... ===============")
    
    t = cputime;
    f = fcn2optimexpr(@computeShapeSensitivity, opts, params, shape.vertices_mat_2d_h);

    prob.Objective = f;
    x0.params = opts.opt.initial_values;


    % options = optimoptions('fmincon', 'MaxIter',5e2, 'TolX', 1e-12, 'FunctionTolerance', 1e-8, 'MaxFunctionEvaluations', 3e4, 'Algorithm','sqp');
    options = optimoptions('fmincon', 'MaxIter', 500, 'TolX', 1e-12, ...
                           'FunctionTolerance', 1e-8, 'MaxFunctionEvaluations', 3e4, ...
                           'Display','off', 'Algorithm', opt_algorithms(opts.opt.algorithm));
    options = optimoptions(options,'PlotFcns','optimplotfval','UseParallel', true);
    % options = optimoptions(options,'UseParallel', true);
    % options = optimoptions('fmincon', 'MaxIter',5e2, 'TolX', 1e-12, 'Display','off', 'FunctionTolerance', 1e-8, 'MaxFunctionEvaluations', 3e4);
    [sol, fval, ~, ~] = solve(prob, x0, 'Options', options);
    final_cost = fval
    elapsed = cputime - t
else
    warning("Skipping optimization, load results from %s", load_name)
    sol = results.sol;
end



%% Parsing results
projective_matrix = findProjectiveMethod(opts, sol.params);
dis_vertices_mat_2d_h = projectionMap(shape.vertices_mat_2d_h, projective_matrix);

[dis_indices, dis_area]  = convhull(dis_vertices_mat_2d_h(1,:), dis_vertices_mat_2d_h(2,:));
dis_vertices_mat_2d_h = dis_vertices_mat_2d_h(:, dis_indices(1:end-1));


% distance checking
num_vertices = size(dis_vertices_mat_2d_h, 2);
num_length_constrs = nchoosek(num_vertices, 2);
indices = nchoosek(linspace(1, num_vertices, num_vertices), 2);
for i = 1:num_length_constrs
    p1 = dis_vertices_mat_2d_h(:, indices(i, 1));
    p2 = dis_vertices_mat_2d_h(:, indices(i, 2));
    dist = sqrt((p1(1) - p2(1))^2 + (p1(2) - p2(2))^2)
end


% scaling area to one
cor_dis_vertices_mat_2d_h = sqrt(1/dis_area) * dis_vertices_mat_2d_h(1:2, :);
[cor_indices, cor_area]  = convhull(cor_dis_vertices_mat_2d_h(1,:), cor_dis_vertices_mat_2d_h(2,:));
cor_dis_vertices_mat_2d_h = cor_dis_vertices_mat_2d_h(:, cor_indices(1:end-1));


% convert back to 3d
dis_vertices_mat_3d_h = [zeros(1, size(cor_dis_vertices_mat_2d_h, 2)); dis_vertices_mat_2d_h];
dis_vertices = convertXYZmatrixToXYZstruct(dis_vertices_mat_3d_h);

cor_dis_vertices_mat_3d_h = [zeros(1, size(cor_dis_vertices_mat_2d_h, 2)); cor_dis_vertices_mat_2d_h];
cor_dis_vertices = convertXYZmatrixToXYZstruct(cor_dis_vertices_mat_3d_h);

%% Plottings
[axes_handles, fig_handles] = createFigHandleWithNumber(1 + opts.opt.param_circle, 1, "projective");
fig = axes_handles(1);
plotConnectedVerticesStructure(fig, shape.vertices, 'k')
plotConnectedVerticesStructure(fig, dis_vertices, 'b')
plotConnectedVerticesStructure(fig, cor_dis_vertices, 'r')

y=linspace(-1,1.5, 10);
if opts.opt.ring_method == 1
    for line = 1:length(opts.opt.line_y)
        plot3(fig, zeros(1, length(y)), y, opts.opt.line_y(line)*ones(length(y)))
    end
end
viewCurrentPlot(fig, "original shape", [-90, 0])

if opts.save_graphics_results
    savefig(fig_handles(1), opts.path.current_path + opts.path.saving_folder + opts.save_name + "-All", 'compact')
    saveas(fig_handles(1), opts.path.current_path + opts.path.saving_folder + opts.save_name + "-All", 'png')
end

if opts.opt.rotate_projected
    angle_list = genAngleList(opts);
    for i = 1:length(angle_list)
        rot_distorted_vertice_h = moveByThetaXY(cor_dis_vertices_mat_2d_h, angle_list(i), [0 0]);
        axes_h = axes_handles(1+i);
        fig_h = fig_handles(i+1);
        plotOptimizeResults(axes_h, fig_h, opts, rot_distorted_vertice_h, "OptimalShape-" + num2str(i));
    end
else
    axes_h = axes_handles(2);
    fig_h = fig_handles(2);
    plotOptimizeResults(axes_h, fig_h, opts, cor_dis_vertices_mat_2d_h, "OptimalShape-" + num2str(i));
end
%%
% fig = axes_handles(2);
% plotConnectedVerticesStructure(fig, cor_dis_vertices, 'r')
% [intersection_t, horzontal_lines] = compute2DIntersectionPoints(opts, dis_vertices_mat_2d_h);
% intersectioned_vertices = [intersection_t(:).vertices];
% if isempty(intersectioned_vertices)
%     warning("No points, no new-target drawing will be done")
% else
%     max_y = max(intersectioned_vertices(1,:));
%     min_y = min(intersectioned_vertices(1,:));
%     y=linspace(min_y, max_y, 10);
%     for line = 1:length(horzontal_lines)
%         plot3(fig, zeros(1, length(y)), y, horzontal_lines(line)*ones(length(y)))
%     end
% 
%     intersection_points = [intersection_t(:).intersection_point];    
%     if ~isempty(intersection_points)
%         scatter3(fig, zeros(1, length(intersection_points)), intersection_points(1, :), intersection_points(2, :), 'fill')
%     end
%     viewCurrentPlot(fig, "Optimal shape", [-89, 0])
% 
%     if opts.save_graphics_results
%     %     savefig(fig_handles(1), opts.path.current_path + opts.path.saving_folder + opts.save_name + "-All", 'compact')
%     %     savefig(fig_handles(2), opts.path.current_path + opts.path.saving_folder + opts.save_name + "-OptimalShape", 'compact')
%         saveas(fig_handles(1), opts.path.current_path + opts.path.saving_folder + opts.save_name + "-All", 'png')
%         saveas(fig_handles(2), opts.path.current_path + opts.path.saving_folder + opts.save_name + "-OptimalShape", 'png')
% 
%     end
% end

%% Saving results
printOutImportantParams(opts, shape, 0);
if opts.save_numerical_results && ~load_saved_settings
    results.computation_time = elapsed;
    results.sol = sol;
    results.cost = final_cost;
    results.shape = shape;
    results.opts = opts;
    save(opts.path.current_path + opts.path.saving_folder + opts.save_name, 'results')
    fprintf("saved as: %s\n", opts.path.current_path + opts.path.saving_folder + opts.save_name)
else
    warning("NOT save current results")
end
elapsed
disp("=================== ALL DONE ===================")
