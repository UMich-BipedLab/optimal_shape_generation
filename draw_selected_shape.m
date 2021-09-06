% clc, clear
addpath(genpath("/home/brucebot/workspace/matlab_utils"))
opts.tag_placement_lib = 0;
opts = loadLibraries(2, opts);

% old shape
% load_path = "./loadable_results/convexity-NoTNoS/small-initial-guess/";
% save_path = "./figures/";
% name = "seed2-sGuess-Conv-nLength-rot6-R4N5Iillumination-nReg-sensitivityPuffibilityRatio-All.fig";

% new shape
opts.load_path = "./loadable_results/convexity-NoTNoS-L1GradSparse/small-initial-guess/";
opts.save_path = "./figures/";
opts.name ="seed2-sGuess-Conv-nLength-L1GradW1e-03M5e+00N2e+01L6-rot6-R4N5Iillumination-nReg-sensitivityPuffibilityRatio-OptimalShape-5.fig";
opts.save_fig = 0;
opts.unit = "inches";
openfig(opts.load_path + opts.name);

%% After export clicked vertices
% Original shape
clc
meter_to_inches = 39.3701;
% original_shape = reshape([cursor_info.Position], [3,4]);
original_shape = [0            0            0            0
                 -0.4302     -0.53745      0.45657       1.0827
                 -0.53837     0.075598      0.57137     -0.15229];
shape1 = computeHeightWidthAnglesLengthOfQuadrilateral(original_shape, meter_to_inches);

% size2
vertices2 = original_shape / 1.47;
shape2 = computeHeightWidthAnglesLengthOfQuadrilateral(vertices2, meter_to_inches);

% 
% % size3
vertices3 = original_shape / 1.47 * 0.5;
shape3 = computeHeightWidthAnglesLengthOfQuadrilateral(vertices3, meter_to_inches);

% size4
vertices4 = original_shape / 1.47 * 0.2;
shape4 = computeHeightWidthAnglesLengthOfQuadrilateral(vertices4, meter_to_inches);

%% Plots
[axes_handles, fig_handles] = createFigHandleWithNumber(5, 1, "Polygon shape");


cur_axes = axes_handles(1);
cur_fig = fig_handles(1);
scatter3(cur_axes, original_shape(1, :), original_shape(2, :), original_shape(3, :))
plotConnectedVerticesStructure(cur_axes, convertXYZmatrixToXYZstruct(original_shape), 'r')

scatter3(cur_axes, vertices2(1, :), vertices2(2, :), vertices2(3, :))
plotConnectedVerticesStructure(cur_axes, convertXYZmatrixToXYZstruct(vertices2), 'g')

scatter3(cur_axes, vertices3(1, :), vertices3(2, :), vertices3(3, :))
plotConnectedVerticesStructure(cur_axes, convertXYZmatrixToXYZstruct(vertices3), 'b')

scatter3(cur_axes, vertices4(1, :), vertices4(2, :), vertices4(3, :))
plotConnectedVerticesStructure(cur_axes, convertXYZmatrixToXYZstruct(vertices4), 'm')
title_name = "all shapes [inches]";
showCurrentPlot(cur_axes, title_name, [-90, 0])
if opts.save_fig
%     saveCurrentPlot(cur_fig, save_path + title_name, "eps", "epsc");
%     exportgraphics(cur_fig,  save_path + title_name + ".pdf")
    saveCurrentPlot(cur_fig, save_path + title_name, "pdf");
    saveCurrentPlot(cur_fig, save_path + title_name, "fig");
    saveCurrentPlot(cur_fig, save_path + title_name, "png");
end

%%
axes_handles(2).Units = 'inches';
showTargetInfo(opts, axes_handles(2), fig_handles(2), shape1);

axes_handles(3).Units = 'inches';
showTargetInfo(opts, axes_handles(3), fig_handles(3), shape2);

axes_handles(4).Units = 'inches';
showTargetInfo(opts, axes_handles(4), fig_handles(4), shape3);

axes_handles(5).Units = 'inches';
showTargetInfo(opts, axes_handles(5), fig_handles(5), shape4);


disp("done")