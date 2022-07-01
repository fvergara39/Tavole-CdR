function Tob_struct = T_world_body(table_dh)

n = size(table_dh,1);
Tij_struct = cell(n,1);
Tob_struct = cell(n,1);
p = sym(zeros(3,n));
zb = sym(zeros(3,n));

% T0body and Origin of Body frames definition
for b=1:n
%     b
    Tij = dh(table_dh,b);
    Tij_struct{b}=Tij;
    if b>1
        Tob_struct{b}=Tob_struct{b-1}*Tij_struct{b};
    else
        Tob_struct{1}=Tij_struct{1};
    end
end