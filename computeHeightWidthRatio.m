function ratio = computeHeightWidthRatio(p1, p2, p3, p4)
    % height/width ratio
    max_height = max([p1(2), p2(2), p3(2), p4(2)]);
    min_height = min([p1(2), p2(2), p3(2), p4(2)]);
    delta_height = abs(max_height - min_height);

    max_width = max([p1(1), p2(1), p3(1), p4(1)]);
    min_width = min([p1(1), p2(1), p3(1), p4(1)]);
    delta_width = abs(max_width - min_width);
    if delta_width~=0
        ratio = delta_height/delta_width;
    else 
        ratio = 0;
    end
end