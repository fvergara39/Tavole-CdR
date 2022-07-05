function check_invol = involutivity(f,g, vars)
%INVOLUTIVITY Involutivity of a vector fields set.
%   INVOLUTIVITY(S) Determines if a vector fields set S is involutive
%   using symbolic variables vector.
%
%   Examples:
%       S = [1 -6*x1^5; 0 -2*x1+x2^3];
%       involutivity(S, [x1, x2]) is 1
%
%   See also DIFFLIE.

% saved_rank = rank(S);
% 
% lenght = size(S, 2);
% for i = 1 : (lenght - 1)
%     for j = (i + 1) : lenght
%         S = [S difflie(S(:,i), S(:,j), x)];
%     end
% end
% involutive = saved_rank == rank(S);
% 
% % UNCOMMENT TO DEBUG
% % 
% %S = simple(S);
% %saved_rank
% new_rank = rank(S)
% 
% end

Lfgn = lieBracket(f,g,vars)
[f,g]
check_invol = is_in_span(Lfgn,[f,g]); 

