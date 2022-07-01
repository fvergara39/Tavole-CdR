function J =compute_J(p4)
syms q1 q2 q3 q4
n = size(p4,2);
J=sym(zeros(3,n));
q = [q1 ;q2; q3; q4];
J = jacobian(p4,q);