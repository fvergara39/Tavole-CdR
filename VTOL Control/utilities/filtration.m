function [Delta_th,span_k, k] = filtration(f,g,vars)
% FILTRATION computes <Delta,Delta0> where Delta and Delta0 are symbolic
% vector fields :
%     Delta = span(f,g1,..,gd);
%     Delta0 = span(g1,..,gd);
% and outputs its dimension r and the number of iterations needed.
% 
% 
Delta_th{1} = g;
span_k(1) = rank(Delta_th{1});
% g = Delta0;
% f = Delta;

for k =2:20
    Lb = lieBracket(f,g,vars,k);
    Delta_th{k} = [Delta_th{k-1},Lb(:,end-1)];
    span_k(k) = rank(Delta_th{k});
    if span_k(k) == span_k(k-1)
%         k
        break
    end
end