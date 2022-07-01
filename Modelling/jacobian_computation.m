function J = jacobian_computation(q, params)

q1 = q(1);
q2 = q(2);
q3 = q(3);
q4 = q(4);

a1 = params(1);
a2 = params(2);
a3 = params(3);
a4 = params(4);

J = [-sin(q1)*(a1 + a3*cos(q2 + q3) + a2*cos(q2) + a4*cos(q2 + q3 + q4)), -cos(q1)*(a3*sin(q2 + q3) + a2*sin(q2) + a4*sin(q2 + q3 + q4)), -cos(q1)*(a3*sin(q2 + q3) + a4*sin(q2 + q3 + q4)), -a4*sin(q2 + q3 + q4)*cos(q1);
    cos(q1)*(a1 + a3*cos(q2 + q3) + a2*cos(q2) + a4*cos(q2 + q3 + q4)), -sin(q1)*(a3*sin(q2 + q3) + a2*sin(q2) + a4*sin(q2 + q3 + q4)), -sin(q1)*(a3*sin(q2 + q3) + a4*sin(q2 + q3 + q4)), -a4*sin(q2 + q3 + q4)*sin(q1);
    0,            a3*cos(q2 + q3) + a2*cos(q2) + a4*cos(q2 + q3 + q4),            a3*cos(q2 + q3) + a4*cos(q2 + q3 + q4),          a4*cos(q2 + q3 + q4)];


end

