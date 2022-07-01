function Y = dynamic_regressor(M,C,G)

n = size(M,1);

syms  g real
q = sym('q',[n 1]);
dq = sym('dq',[n 1]);
m = sym('m',[n 1]);
a = sym('a',[n 1]);
dq_r = sym('dq_r',[n 1]);
ddq_r = sym('ddq_r',[n 1]);

tau = M*ddq_r + C*dq_r + G;
matrix_m = sym(zeros(n,n));
% for i=1:n
%     for j=1:n
%         matrix_m(i,j) = collect(tau(i),m(j));
%         name = ['y',num2str(i),num2str(j),'.txt'];
% 
%         fid = fopen(name, 'w');
%         fwrite(fid, char(matrix_m{j}), 'char');
%         fclose(fid);
%     end
% end

Y = simplify(equationsToMatrix(tau,m));
m
size(Y)