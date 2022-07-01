function M = M_computation(q, params, masses)

g = 9.81;

% Manipulator params
m1 = masses(1);
m2 = masses(2);
m3 = masses(3);
m4 = masses(4);

q1 = q(1);
q2 = q(2);
q3 = q(3);
q4 = q(4);

a1=params(1);
a2=params(2);
a3=params(3);
a4=params(4);

M=[(a1^2*m1)/12 + (a4^2*m4*cos(q2 + q3 + q4)^2)/12 + (m2*cos(q1)^2*(2*a1 + a2*cos(q2))^2)/4 + (m2*sin(q1)^2*(2*a1 + a2*cos(q2))^2)/4 + (m4*cos(q1)^2*(2*a1 + 2*a3*cos(q2 + q3) + 2*a2*cos(q2) + a4*cos(q2 + q3 + q4))^2)/4 + (m4*sin(q1)^2*(2*a1 + 2*a3*cos(q2 + q3) + 2*a2*cos(q2) + a4*cos(q2 + q3 + q4))^2)/4 + (m3*cos(q1)^2*(2*a1 + a3*cos(q2 + q3) + 2*a2*cos(q2))^2)/4 + (m3*sin(q1)^2*(2*a1 + a3*cos(q2 + q3) + 2*a2*cos(q2))^2)/4 + (a3^2*m3*cos(q2 + q3)^2)/12 + (a1^2*m1*cos(q1)^2)/4 + (a2^2*m2*cos(q2)^2)/12 + (a1^2*m1*sin(q1)^2)/4,                                                                                                                                                        0,                                                                                                                            0,                                                   0;
    0, (a2^2*m2)/3 + a2^2*m3 + a2^2*m4 + (a3^2*m3)/3 + a3^2*m4 + (a4^2*m4)/3 + a2*a4*m4*cos(q3 + q4) + a2*a3*m3*cos(q3) + 2*a2*a3*m4*cos(q3) + a3*a4*m4*cos(q4), (a3^2*m3)/3 + a3^2*m4 + (a4^2*m4)/3 + (a2*a4*m4*cos(q3 + q4))/2 + (a2*a3*m3*cos(q3))/2 + a2*a3*m4*cos(q3) + a3*a4*m4*cos(q4), (a4*m4*(2*a4 + 3*a2*cos(q3 + q4) + 3*a3*cos(q4)))/6;
    0,                             (a3^2*m3)/3 + a3^2*m4 + (a4^2*m4)/3 + (a2*a4*m4*cos(q3 + q4))/2 + (a2*a3*m3*cos(q3))/2 + a2*a3*m4*cos(q3) + a3*a4*m4*cos(q4),                                                                       (a3^2*m3)/3 + a3^2*m4 + (a4^2*m4)/3 + a3*a4*m4*cos(q4),                     (a4*m4*(2*a4 + 3*a3*cos(q4)))/6;
    0,                                                                                                      (a4*m4*(2*a4 + 3*a2*cos(q3 + q4) + 3*a3*cos(q4)))/6,                                                                                              (a4*m4*(2*a4 + 3*a3*cos(q4)))/6,                                         (a4^2*m4)/3];

