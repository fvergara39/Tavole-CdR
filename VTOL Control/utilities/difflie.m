function U = difflie(X, Y, variables)
% Solve for the first lie derivative 
U = jacobian(Y, variables)*X;

end