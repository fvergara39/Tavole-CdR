function Lfgn = lieBracket_n(f,g,vars,n)
% LIEBRACKET computes th edirectional derivative of a symbolic vector 
% field g(vars) along a symbolic vector field f(vars)
% vars is a symbolic vector of variables
% Lfg(x) = (dg/dx)*f(x) - (df/dx)*g(x)

% Output:
% ad_fng =  [ g    [f,g]  [g,[f,g]] [g,[g,[f,g]]] .... ]
%        n=   0      1         2         3
%             g    Lf_g   Lf2_g      Lf3_g

Lfgn = sym(zeros(length(f),n+1));
Lfgn(:,1) = g;
Lfgn(:,2) = jacobian(g ,vars)*f - jacobian(f,vars)*g;
if n>0
    for col = 3:n+1
        Lfgn(:,col) = jacobian(Lfgn(:,col-1) ,vars)*g - jacobian(g,vars)*Lfgn(:,col-1);
    end
end
Lfgn = expand(Lfgn);

