function [opts, shape, params] = loadUserDefinedSettings(opts)
    %% General optimization parameters
    opts.opt.line_y = [-0.4, -0.2, 0.1, 0.2]; % y in 2d, z in 3d
    opts.opt.param_se2 = 25; % parameterize se2 sphere
    opts.opt.algorithm = 1; % fmincon optimization
    

    %% Methods to generate random shape
    % 1: random with full rank constraints
    % 2: descompose projective matrix
    % 3: descompose projective matrix with translation 0
    % 4: descompose projective matrix with translation 0 and scaling 1
    opts.opt.twisted_method = 4; % how to find a twisted square

    
    %% Initialize Optimization
    % 0: use provided initial guess
    % 1: random initial with seed (2)
    % 2: initial with ones
    opts.opt.random_initials = 1;
    
    % if using random init, whether to use large initials
    opts.opt.large_initials = 0;
    opts.opt.random_seed = 2;
    
    
    %%  optimization constraints
    opts.opt.use_constraints = 1; 
    opts.opt.convexity_constraints = 1;
%     opts.opt.slope_constraints = 1;
    opts.opt.length_constraints = 0;
    
    
    %% Rotate the projected shape
    opts.opt.rotate_projected = 1;
    
    % if rotate, how many times? 
    % 2 stands for [0, 180] , 3 stands for [0, 120, 240], 4 stands for [0, 90, 1809, 270]
    opts.opt.param_circle = 6;

    
    %% Horizontal lines method
    % 1: given fixed lines from 'opts.opt.line_y'
    % 2: 1/5, 2/5, 3/5, 4/5 from the top of the vertices
    % 3: lidar illuminate N parts indivisually: 
    %       Take N=3 for an example:
    %           (I)   above centroid
    %           (II)  include centroid
    %           (III)  below centroid
    opts.opt.ring_method = 3 ;
    
    % if rings are not given (2, 3), 
    % how many rings should pass through the target's illumination region
    % for method-2, the illumination region is the whole target
    % for method-3, the illumination region is specified below
    opts.opt.num_ring = 4; 
    
    % how many illumination regions on the target
    opts.opt.illumination_region = 5;

    
    %% Cost
    % cost functions
    % 1: sensitivity only
    % 2: sensitivity with puffiblility
    % 3: sensitivity, puffibility with ratio
    % 4: sensitivity, puffibility with ratio and edge sign
    opts.opt.cost = 3;
    
    % cost regulizer
    opts.opt.regulizer = 0;
    opts.opt.regulizer_ratio = 1e-5;
    
    % L1 gradient
    opts.opt.L1_gradient = 0;
    opts.opt.L1_gradient_weight = 1e0;
    opts.opt.grid_length = 5; % meter
    opts.opt.point_per_Ncm = 24; % points per N cm
    opts.opt.L1_sparse_level = 6;
%     spaser_list = linspace(opts.opt.point_per_Ncm/opts.opt.L1_sparse_level, ...
%                            opts.opt.point_per_Ncm, opts.opt.L1_sparse_level)
    
    %% Initial shape
    shape.shape = 4;
    shape.length = 1;
    shape.vertices = genShape([], shape.length, shape.shape);
    shape.vertices_mat = convertXYZstructToXYZmatrix(shape.vertices);
    shape.org_area = polyarea(shape.vertices.y, shape.vertices.z);
    shape.vertices_mat_2d_h = [shape.vertices_mat(2:3, :); ones(1, shape.shape)]; % [x; y; 1]
    
    
    %%
    opts.inial_guess = [0.84656     0.079645      0.50525     0.065287      0.42812  0.096531];
%     load('seed.mat')
%     [params, opts.opt.num_parameters, opts.opt.initial_values, opts.seed] = constructOptimizationParams(opts, opts.inial_guess, seed);
    [params, opts.opt.num_parameters, opts.opt.initial_values, opts.opt.seed_t] = constructOptimizationParams(opts, opts.inial_guess, opts.opt.random_seed);
    [opts, shape] = printOutImportantParams(opts, shape, 1);
    % seed
    % rng(seed)
    % rand(1,6)
%     initial_values = opts.opt.initial_values
end