function dJ = diff_jacobian(q, dq, params)

q1 = q(1);
q2 = q(2);
q3 = q(3);
q4 = q(4);

dq1 = dq(1);
dq2 = dq(2);
dq3 = dq(3);
dq4 = dq(4);

a1 = params(1);
a2 = params(2);
a3 = params(3);
a4 = params(4);

dJ = [  sin(q1(t))*(a3*sin(q2(t) + q3(t))*(dq2 + dq3) + a2*sin(q2(t))*dq2 + a4*sin(q2(t) + q3(t) + q4(t))*(dq2 + dq3 + dq4)) - cos(q1(t))*(a1 + a2*cos(q2(t)) + a4*cos(q2(t) + q3(t) + q4(t)) + a3*cos(q2(t) + q3(t)))*dq1,   sin(q1(t))*dq1*(a2*sin(q2(t)) + a4*sin(q2(t) + q3(t) + q4(t)) + a3*sin(q2(t) + q3(t))) - cos(q1(t))*(a3*cos(q2(t) + q3(t))*(dq2 + dq3) + a2*cos(q2(t))*dq2 + a4*cos(q2(t) + q3(t) + q4(t))*(dq2 + dq3 + dq4)),   sin(q1(t))*dq1*(a4*sin(q2(t) + q3(t) + q4(t)) + a3*sin(q2(t) + q3(t))) - cos(q1(t))*(a3*cos(q2(t) + q3(t))*(dq2 + dq3) + a4*cos(q2(t) + q3(t) + q4(t))*(dq2 + dq3 + dq4)),   a4*sin(q1(t))*sin(q2(t) + q3(t) + q4(t))*dq1 - a4*cos(q1(t))*cos(q2(t) + q3(t) + q4(t))*(dq2 + dq3 + dq4);
    - cos(q1(t))*(a3*sin(q2(t) + q3(t))*(dq2 + dq3) + a2*sin(q2(t))*dq2 + a4*sin(q2(t) + q3(t) + q4(t))*(dq2 + dq3 + dq4)) - sin(q1(t))*(a1 + a2*cos(q2(t)) + a4*cos(q2(t) + q3(t) + q4(t)) + a3*cos(q2(t) + q3(t)))*dq1, - sin(q1(t))*(a3*cos(q2(t) + q3(t))*(dq2 + dq3) + a2*cos(q2(t))*dq2 + a4*cos(q2(t) + q3(t) + q4(t))*(dq2 + dq3 + dq4)) - cos(q1(t))*(a2*sin(q2(t)) + a4*sin(q2(t) + q3(t) + q4(t)) + a3*sin(q2(t) + q3(t)))*dq1, - sin(q1(t))*(a3*cos(q2(t) + q3(t))*(dq2 + dq3) + a4*cos(q2(t) + q3(t) + q4(t))*(dq2 + dq3 + dq4)) - cos(q1(t))*(a4*sin(q2(t) + q3(t) + q4(t)) + a3*sin(q2(t) + q3(t)))*dq1, - a4*sin(q1(t))*cos(q2(t) + q3(t) + q4(t))*(dq2 + dq3 + dq4) - a4*cos(q1(t))*sin(q2(t) + q3(t) + q4(t))*dq1;
    0,                                                                                                                  - a3*sin(q2(t) + q3(t))*(dq2 + dq3) - a2*sin(q2(t))*dq2 - a4*sin(q2(t) + q3(t) + q4(t))*(dq2 + dq3 + dq4),                                                                                                  - a3*sin(q2(t) + q3(t))*(dq2 + dq3) - a4*sin(q2(t) + q3(t) + q4(t))*(dq2 + dq3 + dq4),                                                                       -a4*sin(q2(t) + q3(t) + q4(t))*(dq2 + dq3 + dq4)];

end