function showTargetInfo(opts, cur_axes, cur_fig, cur_shape)

    scatter3(cur_axes, cur_shape.unsorted_mat(1, :),  cur_shape.unsorted_mat(2, :),  cur_shape.unsorted_mat(3, :))
    plotConnectedVerticesStructure(cur_axes, convertXYZmatrixToXYZstruct(cur_shape.unsorted_mat), 'r')
    title_name = num2str(cur_shape.height) + " x " + num2str(cur_shape.width) + " " + opts.unit ;
    showCurrentPlot(cur_axes, title_name, [-90, 0])

    text(cur_axes, cur_shape.d1_mean(1), cur_shape.d1_mean(2), cur_shape.d1_mean(3), num2str(cur_shape.d1))
    text(cur_axes, cur_shape.d2_mean(1), cur_shape.d2_mean(2), cur_shape.d2_mean(3), num2str(cur_shape.d2))
    text(cur_axes, cur_shape.d3_mean(1), cur_shape.d3_mean(2), cur_shape.d3_mean(3), num2str(cur_shape.d3))
    text(cur_axes, cur_shape.d4_mean(1), cur_shape.d4_mean(2), cur_shape.d4_mean(3), num2str(cur_shape.d4))
    text(cur_axes, cur_shape.sorted_vertices(1,1), cur_shape.sorted_vertices(2,1), cur_shape.sorted_vertices(3,1), num2str(cur_shape.ang1))
    text(cur_axes, cur_shape.sorted_vertices(1,2), cur_shape.sorted_vertices(2,2), cur_shape.sorted_vertices(3,2), num2str(cur_shape.ang2))
    text(cur_axes, cur_shape.sorted_vertices(1,3), cur_shape.sorted_vertices(2,3), cur_shape.sorted_vertices(3,3), num2str(cur_shape.ang3))
    text(cur_axes, cur_shape.sorted_vertices(1,4), cur_shape.sorted_vertices(2,4), cur_shape.sorted_vertices(3,4), num2str(cur_shape.ang4))

    if opts.save_fig
%         saveCurrentPlot(cur_fig, opts.save_path + title_name, "eps", "epsc");
        saveCurrentPlot(cur_fig, opts.save_path + title_name, "eps", "vector");
        saveCurrentPlot(cur_fig, opts.save_path + title_name, "pdf", "vector");
        saveCurrentPlot(cur_fig, opts.save_path + title_name, "fig");
        saveCurrentPlot(cur_fig, opts.save_path + title_name, "png");
    end
end