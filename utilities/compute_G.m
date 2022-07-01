function G = compute_G(q,Jplink,z_dir)
syms g real
n = length(q);

if z_dir==1
    gvec = -g*[1,0,0]';
elseif z_dir==2
    gvec = -g*[0,1,0]';
elseif z_dir==3
    gvec = -g*[0,0,1]';
end

G = sym(zeros(n,1));
m = sym('m',[n,1]);

for i=1:n
    for j=1:n
        mj = m(j);
%         size(Jplink{j})
        G(i)= G(i)-mj*gvec.'*Jplink{j}(:,i);
    end
end
G = simplify(G);
end