function d = dim_span (matrix)

n = max(size(matrix));
rank(matrix);

if rank(matrix) == n
%     span_vec = eye(n);
d = n;
else
    combinations = rref(matrix)
    [span_vec,idx]=licols(combinations)
end