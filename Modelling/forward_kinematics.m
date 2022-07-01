function [p0, p1, p2, p3, p4] = forward_kinematics(q,params)

q1 = q(1);
q2 = q(2);
q3 = q(3);
q4 = q(4);

a1 = params(1);
a2 = params(2);
a3 = params(3);
a4 = params(4);

p0 = [0;0;0];
p1 = p0 + [a1*cos(q1); a1*sin(q1); 0];
p2 = p1 + [a2*cos(q2)*cos(q1); a2*cos(q2)*sin(q1); a2*sin(q2)];
p3 = p2 + [cos(q1)*(a3*cos(q2 + q3)); sin(q1)*(a3*cos(q2 + q3)); a3*sin(q2 + q3)];
p4 = p3 + [cos(q1)*(a4*cos(q2 + q3 + q4)); sin(q1)*(a4*cos(q2 + q3 + q4)); a4*sin(q2 + q3 + q4)];

end