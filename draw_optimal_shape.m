clc, clear
% optimal-shape/seed2-sGuess-Conv-nLength-rot6-R4N5Iillumination-nReg-sensitivityPuffibilityRatio-OptimalShape-1.png
[axes_handles, fig_handles] = createFigHandleWithNumber(3, 20,"OptimalShape", 1, 1, 30);
optimal_shape = load('original_shape.mat');

H = constructHByRPYXYZMovingPoints([300, 0 0], [0 0 0]);
optimal_shape_rotated = H * convertToHomogeneousCoord(optimal_shape.original_shape);


%%
[axes_h, fig_h] = getCurrentFigure(1, axes_handles, fig_handles);
cla(axes_h);
plot_opts.line_width = 7;
plot_opts.marker_size = 200; 
plotShape(axes_h, optimal_shape_rotated, 'k', 'k', plot_opts);

vertex_l = optimal_shape_rotated(2:3, 1);
vertex_t = optimal_shape_rotated(2:3, 2);
vertex_r = optimal_shape_rotated(2:3, 3);
vertex_b = optimal_shape_rotated(2:3, 4);


% left
putText(axes_h, 0, vertex_l(1)+ 0.04, ...
    vertex_l(2), ...
    "$(" + num2str(vertex_l(1), 3) + ", " ...
    + num2str(vertex_l(2), 3) +")$", 'k', 'right')
left_deg = rad2deg(computeAngle(vertex_t, vertex_l, vertex_b));
putText(axes_h, 0, vertex_l(1) - 0.12, ...
    vertex_l(2)+ 0.03, ...
    "$" + num2str(left_deg, 3) + "^\circ$", 'k', 'left')
plotAngleWith2DArc(axes_h , vertex_t, vertex_l, vertex_b, 0.1, "YZ", plot_opts)


% top 
putText(axes_h, 0, vertex_t(1)+0.05, ...
    vertex_t(2)+0.06, ...
    "$(" + num2str(vertex_t(1), 3) + ", " ...
    + num2str(vertex_t(2), 3) +")$", 'k', 'center')
top_deg = rad2deg(computeAngle(vertex_r, vertex_t, vertex_l));
putText(axes_h, 0, vertex_t(1)+0.03, ...
    vertex_t(2)-0.15, ...
    "$" + num2str(top_deg, 3) + "^\circ$", 'k', 'left')
plotAngleWith2DArc(axes_h , vertex_r, vertex_t, vertex_l, 0.1, "YZ", plot_opts)


% right
putText(axes_h, 0, vertex_r(1)-0.05, ...
    vertex_r(2), ...
    "$(" + num2str(vertex_r(1), 3) + ", " ...
    + num2str(vertex_r(2), 3) +")$", 'k', 'left')
right_deg = rad2deg(computeAngle(vertex_b, vertex_r, vertex_t));
putText(axes_h, 0, vertex_r(1)+0.11, ...
    vertex_r(2)-0.08, ...
    "$" + num2str(right_deg, 3) + "^\circ$", 'k', 'right')
plotAngleWith2DArc(axes_h , vertex_b, vertex_r, vertex_t, 0.1, "YZ", plot_opts)


% bottom
putText(axes_h, 0, vertex_b(1)-0.03, ...
    vertex_b(2)+0.05, ...
    "$(" + num2str(vertex_b(1), 3) + ", " ...
    + num2str(vertex_b(2), 3) +")$", 'k', 'left')
bottom_deg = rad2deg(computeAngle(vertex_l, vertex_b, vertex_r));
putText(axes_h, 0, vertex_b(1)+0.03, ...
    vertex_b(2)+0.12, ...
    "$" + num2str(bottom_deg, 3) + "^\circ$", 'k', 'right')
plotAngleWith2DArc(axes_h ,vertex_l, vertex_b, vertex_r, 0.1, "YZ", plot_opts)

% top-left edge
dis_tl = norm(vertex_t - vertex_l);
anchor_tl = (vertex_t + vertex_l) ./2;
putText(axes_h, 0, anchor_tl(1)+0.05, ...
    anchor_tl(2), ...
    "$" + num2str(dis_tl, 3) + "$", 'k', 'right')

% top-right edge
dis_tr = norm(vertex_t - vertex_r);
anchor_tr = (vertex_t + vertex_r) ./2;
putText(axes_h, 0, anchor_tr(1)-0.05, ...
    anchor_tr(2)+0.03, ...
    "$" + num2str(dis_tr, 3) + "$", 'k', 'left')

% right-bottom edge
dis_rb = norm(vertex_r - vertex_b);
anchor_rb = (vertex_r + vertex_b) ./2;
putText(axes_h, 0, anchor_rb(1)-0.04, ...
    anchor_rb(2) - 0.02, ...
    "$" + num2str(dis_rb, 3) + "$", 'k', 'left')

% bottom-right edge
dis_lb = norm(vertex_l - vertex_b);
anchor_lb = (vertex_l + vertex_b) ./2;
putText(axes_h, 0, anchor_lb(1), ...
    anchor_lb(2) - 0.05, ...
    "$" + num2str(dis_lb, 3) + "$", 'k', 'right')


viewCurrentPlot(axes_h, "", [-90, 0])
% saveCurrentPlot(fig_h, "OptimalShape", 'png');

%%
% clc
% bag_files_path = "/home/brucebot/workspace/lc-calibration/data/optimal_shape/Jul-14-2021/distance/bagfiles/";
% bag_file_name = "FRBAtrium04m.bag";
% mat_files_path = "/home/brucebot/workspace/lc-calibration/data/optimal_shape/Jul-14-2021/distance/";
% mat_file_name = "FRBAtrium04m-LargeTarget.mat";
% % mat_files = loadMatFilesFromFolder(mat_files_path, "*FRBAtrium04m-LargeTarget*.mat");
% % 
% % 
% % vertices = load("original_shape.mat");
% % rotatated_ideal = [300 0 0];
% % optimal_shape = moveByRPYXYZ(vertices.original_shape, rotatated_ideal, [0 0 0]);
% % optimal_shape = optimal_shape(1:3, :);
% % optimal_shape = mat_files.target_scale*optimal_shape;
% 
% 
% % [axes_h, fig_h] = getCurrentFigure(2, axes_handles, fig_handles);
% % cla(axes_h)
% % loadBagImg(axes_h, bag_files_path, bag_file_name)
% % P = [334.0578 -366.0004 24.3086 -26.4665;
% %      276.8475 17.3872 -356.5415 -86.8734;
% %      0.9948, 0.0454 0.0913 -0.0912];
% % projectBackToImage(axes_h, P, convertToHomogeneousCoord(optimal_shape), 50, '.r', "", 1,1)
% % viewCurrentPlot(axes_h, "", [0, 90])
% 
% 
% pc = loadPointCloud(mat_files_path, mat_file_name);
% accumulated_payload = getPayload(pc, 1);
% payload_removed_zeros = removeZeros(accumulated_payload);
% [axes_h, fig_h] = getCurrentFigure(2, axes_handles, fig_handles);
% cla(axes_h)
% loadBagImg(axes_h, bag_files_path, bag_file_name)
% P = [336.2635 -363.8469   26.1566  -33.9048
% 277.2739   17.7768 -356.1908  -86.3902
% 0.9943    0.0519    0.0926   -0.0829];
% projectBackToImage(axes_h, P, convertToHomogeneousCoord(payload_removed_zeros(1:3, :)), 50, '.r', "", 1,1)
% % scatter3(axes_h, payload_removed_zeros(1,:), payload_removed_zeros(2,:), payload_removed_zeros(3,:), '.k');
% viewCurrentPlot(axes_h, "", [0, 90])

%%
%
[axes_h, fig_h] = getCurrentFigure(3, axes_handles, fig_handles);
plotShape(axes_h, optimal_shape_rotated, 'k', 'k', plot_opts);
grid(axes_h, 'off')
popCurrentFigure(fig_h);
set(gca,'visible','off')
set(gca,'XColor', 'none','YColor','none')
set(gcf,'color','w');
viewCurrentPlot(axes_h, "", [-90, 0])
popCurrentFigure(fig_handles(1))
% saveCurrentPlot(fig_h, "OptimalShapeForDrawing", 'png');