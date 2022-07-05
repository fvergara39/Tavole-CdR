function Lfgn = lieBracket(f,g,vars)
% LIEBRACKET computes th edirectional derivative of a symbolic vector 
% field g(vars) along a symbolic vector field f(vars)
% vars is a symbolic vector of variables
% Lfg(x) = (dg/dx)*f(x) - (df/dx)*g(x)

% Output:
% ad_fng =  [f,g] 


Lfgn(:,2) = jacobian(g ,vars)*f - jacobian(f,vars)*g;

