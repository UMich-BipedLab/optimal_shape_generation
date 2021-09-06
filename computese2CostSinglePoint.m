function cost = computese2CostSinglePoint(p1, p2, omega, v, u)
    a = p1(1);
    b = p1(2);
    c = p2(1);
    d = p2(2);
    cost = omega*((a-c)*(a*d-b*c+c*yc-a*yc)/(b-d)^2-yc)+u+v*(c-a)/(b-d);
end