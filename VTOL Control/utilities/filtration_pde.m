function [Delta_th,saved_dim, max_k] = filtration_pde(f,g,vars,vars0)
% FILTRATION computes <Delta,Delta0> where Delta and Delta0 are symbolic
% vector fields :
%     Delta = span(f,g1,..,gd);
%     Delta0 = span(g1,..,gd);
% and outputs its dimension r evaluating it at the equilibrium point vars0
% and the number of iterations needed.
% 
% 
Delta_th{1} = g;
saved_dim(1) = rank(subs(Delta_th{1},vars,vars0));
% g = Delta0;
% f = Delta;
increase = true;
k =2;
while increase
% for k =2:20
    Lb = lieBracket(f,g,vars,k);
    Delta_th{k} = [Delta_th{k-1},Lb(:,end-1)];
    subs(Delta_th{k},vars,vars0)
    saved_dim(k) = rank(subs(Delta_th{k},vars,vars0));
    if saved_dim(k) == saved_dim(k-1)
        increase = false;
    else
        k = k+1;
    end
end
max_k = k-1;