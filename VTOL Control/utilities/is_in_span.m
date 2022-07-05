function flag = is_in_span(v, varargin)
% Test whether or not vector v is in the span of a set
% of vectors varargin.
A = [];
n = length(varargin);
for i=1:n
 u = varargin{i};
 u = u';
 A = [A u(:)];
end
v = v';
v = v(:);
if rank(A) == rank([A v])
 disp(' Given vector is in the span.')
 flag = true;
else
 disp(' Given vector is not in the span.')
 flag = false;
end