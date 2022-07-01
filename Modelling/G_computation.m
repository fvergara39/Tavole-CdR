function G = G_computation(q, params, masses)

% Basic params
g = 9.81;

% real parameters
q1 = q(1);
q2 = q(2);
q3 = q(3);
q4 = q(4);

a1=params(1);
a2=params(2);
a3=params(3);
a4=params(4);

m1 = masses(1);
m2 = masses(2);
m3 = masses(3);
m4 = masses(4);
% Gravity vector

G = [0;
    (g*(a2*m2*cos(q2) + 2*a2*m3*cos(q2) + 2*a2*m4*cos(q2) + a4*m4*cos(q2 + q3 + q4) + a3*m3*cos(q2 + q3) + 2*a3*m4*cos(q2 + q3)))/2;
    (a3*g*m3*cos(q2 + q3))/2 + a3*g*m4*cos(q2 + q3) + (a4*g*m4*cos(q2 + q3 + q4))/2;
    (a4*g*m4*cos(q2 + q3 + q4))/2];

