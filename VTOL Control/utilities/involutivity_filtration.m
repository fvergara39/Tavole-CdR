function [Delta_th,span_k, max_k] = involutivity_filtration(f,g,vars)
% INVOLUTIVE_FILTRATION computes <Delta,Delta> where Delta is a symbolic
% vector field :
%     Delta = span(f,g1,..,gd);

% and outputs its dimension r evaluating it at the equilibrium point vars0
% and the number of iterations needed.
% 
% 
Delta_th{1} = g;
span_k(1) = rank(subs(Delta_th{1},vars,vars0));
% g = Delta0;
% f = Delta;
increase = true;
k =2;
while increase
% for k =2:20
    Lb = lieBracket(f,g,vars,k);
    Delta_th{k} = [Delta_th{k-1},Lb(:,end-1)];
    subs(Delta_th{k},vars,vars0)
    span_k(k) = rank(subs(Delta_th{k},vars,vars0));
    if span_k(k) == span_k(k-1)
        increase = false;
    else
        k = k+1;
    end
end
max_k = k-1;