function cost_se2 = computese2Cost(edge_point, p1, p2, omega, v, u)
    yc = edge_point(2);
    a = p1(1);
    b = p1(2);
    c = p2(1);
    d = p2(2);
    vx = omega*((a-c)*(a*d-b*c+c*yc-a*yc)/(b-d)^2-yc)+u+v*(c-a)/(b-d);
    vy = 0;
    cost_se2 = [vx, vy];
end