function [intersection_point,  status] = compute2DIntersectionPointsGivenHorizontalLines(p1,p2,line)
    % status = 0: horizontal line 
    % status = 1: intersection point is outside of the segment 
    % status = 2: points on a vertices 
    % status = 3: points inside the segment

    status = 0;
    y_offect = p2(2) - p1(2);
    intersection_point = [];
    
    % p1, p2 are not horizontal
    if abs(y_offect) > 1e-5
        x = (p2(1) - p1(1))/(p2(2) - p1(2)) * (line - p1(2)) + p1(1);
        min_x = min(p1(1), p2(1));
        max_x = max(p1(1), p2(1));
        threshold = 1e-6;
        if x > min_x && x < max_x
            if abs(x - min_x) < threshold || abs(x - max_x) < threshold
                % on p1 or p2
                status = 2;
            else
                status = 3;
            end
        else
            status = 1;
        end
        intersection_point = [x; line];
    end
end