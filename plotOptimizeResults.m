function plotOptimizeResults(axes_h, fig_h,  opts, cor_dis_vertices_mat_h, name)
    cor_dis_vertices_3d_mat_h = [zeros(1, size(cor_dis_vertices_mat_h, 2)); cor_dis_vertices_mat_h];
    plotConnectedVerticesStructure(axes_h, convertXYZmatrixToXYZstruct(cor_dis_vertices_3d_mat_h), 'r')
    
    if opts.opt.ring_method == 3
        illumination_region = opts.opt.illumination_region;
    else
        illumination_region = 1;
    end
    
    color_list = getColors(illumination_region);
    for j = 1:illumination_region
        opts.opt.current_ill_region = j;
        [intersection_t, horzontal_lines] = compute2DIntersectionPoints(opts, cor_dis_vertices_mat_h);
        intersectioned_vertices = [intersection_t(:).vertices];
        if isempty(intersectioned_vertices)
            warning("No points, no new-target drawing will be done")
        else
            max_y = max(intersectioned_vertices(1,:));
            min_y = min(intersectioned_vertices(1,:));
            y=linspace(min_y, max_y, 10);
            for line = 1:length(horzontal_lines)
                plot3(axes_h, zeros(1, length(y)), y, horzontal_lines(line)*ones(length(y)), 'Color', color_list{j})
            end

            intersection_points = [intersection_t(:).intersection_point];    
            if ~isempty(intersection_points)
                scatter3(axes_h, zeros(1, length(intersection_points)), intersection_points(1, :), ...
                         intersection_points(2, :), 'fill', 'o','MarkerEdgeColor', color_list{j}, 'MarkerFaceColor', color_list{j})
            end
            viewCurrentPlot(axes_h, name, [-89, 0])

            if opts.save_graphics_results
                savefig(fig_h, opts.path.current_path + opts.path.saving_folder + opts.save_name + "-" + name, 'compact')
                saveas(fig_h, opts.path.current_path + opts.path.saving_folder + opts.save_name + "-" + name, 'png')
            end
        end
    end
end
