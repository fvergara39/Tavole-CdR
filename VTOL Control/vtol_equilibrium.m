%% Find equilibrium point
p = optimvar('p',8);
% syms x0 x0_dot y0 y0_dot theta0 theta0_dot u01 u02
p0.p = [10 10 10 10 10 10 10 10];

% Create equations as optimization equality expressions.
d=-0.1;

eq1 = p(2) == 0;
eq2 = -sin(p(5))*p(7) + d*cos(p(5))*p(8) ==0;
eq3 = p(4) == 0;
eq4 = cos(p(5))*p(7) + d*sin(p(5))*p(8) - 1 == 0;
eq5 = p(6) == 0;
eq6 = p(8) == 0;

% Create an equation problem, and place the equations in the problem.
prob = eqnproblem;
prob.Equations.eq1 = eq1;
prob.Equations.eq2 = eq2;
prob.Equations.eq3 = eq3;
prob.Equations.eq4 = eq4;
prob.Equations.eq5 = eq5;
prob.Equations.eq6 = eq6;

% Review the problem
show(prob)

% Solve the problem starting from the initial point p0. For the problem-based approach, specify the initial point as a structure, with the variable names as the fields of the structure. For this problem, there is only one variable, x.
[sol,fval,exitflag] = solve(prob,p0)

% Diplay the solution
disp(sol.p)




















