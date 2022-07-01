function M_sym = compute_M(table_dh, Jplink, Jolink, I)
%COMPUTE_M computes the Mass Matrix
syms m1 m2 m3 m4 %a1 a2 a3 a4
n = size(table_dh,1); 
m = [m1,m2,m3,m4];

Tob_struct = T_world_body(table_dh);
M_sym=sym(zeros(n,n));

for i=1:n
    Ri = Tob_struct{i}(1:3,1:3);
    M_sym = M_sym + m(i)*Jplink{i}.'*Jplink{i} + Jolink{i}.'*Ri*I{i}*Ri.'*Jolink{i};
end
M_sym = simplify(M_sym);

% calcolo degli jacobiani
% b1 = m1*(Jp1.')*Jp1 + (Jo1.')*R1*I1*(R1.')*Jo1;
% b2 = m2*(Jp2.')*Jp2 + (Jo2.')*R2*I2*(R2.')*Jo2;
% b3 = m3*(Jp3.')*Jp3 + (Jo3.')*R3*I3*(R3.')*Jo3;
% b4 = m4*(Jp4.')*Jp4 + (Jo4.')*R4*I4*(R4.')*Jo4;
% 
% M = simplify(b1+b2+b3+b4);



% Jp1 = zeros(3,n);
% Jp2 = [ -a2/2*sin(q(1))*cos(q(2)), a2/2*cos(q(1))*sin(q(2))  , 0 , 0;
%          a2/2*cos(q(1))*cos(q(2)), -a2/2*sin(q(1))*sin(q(2)) , 0 , 0;
%                 0            ,        cos(q(2))        , 0 , 0];
% Jp3 = [-sin(q(1))*a2*cos(q(2))+a3/2*cos(q(2)+q(3)) , -cos(q(1))*a2*sin(q(2))+a3/2*sin(q(2)+q(3)) , -a3/2*cos(q(1))*sin(q(2)+q(3)), 0;
%         cos(q(1))*a2*cos(q(2))+a3/2*cos(q(2)+q(3)) , -sin(q(1))*a2*sin(q(2))+a3/2*sin(q(2)+q(3)) , -a3/2*sin(q(1))*sin(q(2)+q(3)), 0;
%               0       ,  a2*cos(q(2))+a3/2*cos(q(2)+q(3))        ,  a3/2*cos(q(2)+q(3))        , 0];
% Jp4 = [-sin(q(1))* a2*cos(q(2))+a3*cos(q(2)+q(3))+a4/2*cos(q(2)+q(3)+q(4)) , -cos(q(1))*a2*sin(q(2))+a3*sin(q(2)+q(3))+a4/2*sin(q(2)+q(3)+q(4)) ,  -cos(q(1))*a3*sin(q(2)+q(3))+a4/2*sin(q(2)+q(3)+q(4)) , -cos(q(1))*a4/2*sin(q(2)+q(3)+q(4))
%         cos(q(1))* a2*cos(q(2))+a3*cos(q(2)+q(3))+a4/2*cos(q(2)+q(3)+q(4)) , -sin(q(1))*a2*sin(q(2))+a3*sin(q(2)+q(3))+a4/2*sin(q(2)+q(3)+q(4)) ,  -sin(q(1))*a3*sin(q(2)+q(3))+a4/2*sin(q(2)+q(3)+q(4)) , -sin(q(1))*a4/2*sin(q(2)+q(3)+q(4))
%                0       ,       a2*cos(q(2))+a3*cos(q(2)+q(3))+a4/2*cos(q(2)+q(3)+q(4))    ,   a3*cos(q(2)+q(3))+a4/2*cos(q(2)+q(3)+q(4))         ,  a4/2*cos(q(2)+q(3)+q(4))];
% 
% Jo1 = [0 , 0 , 0 , 0;
%        0 , 0 , 0 , 0;
%        1 , 0 , 0 , 0];
% Jo2 = [0 ,  sin(q(1)) , 0 , 0;
%        0 , -cos(q(1)) , 0 , 0;
%        1 ,     0    , 0 , 0];
% Jo3 = [0 ,  sin(q(1)) , sin(q(1)) , 0;
%        0 , -cos(q(1)) , -cos(q(1)), 0;
%        1 ,     0    ,    0    , 0];
% Jo4 = [0 ,  sin(q(1)) , sin(q(1)) ,  sin(q(1));
%        0 , -cos(q(1)) , -cos(q(1)), -cos(q(1));
%        1 ,     0    ,    0    ,   0];
% 
% R1 = [cos(q(1)), 0,  sin(q(1));
%     sin(q(1)), 0, -cos(q(1));
%       0, 1,        0];
% R2 = [cos(q(1))*cos(q(2)), -cos(q(1))*sin(q(2)),  sin(q(1));
%       cos(q(2))*sin(q(1)), -sin(q(1))*sin(q(2)), -cos(q(1));
%       sin(q(2)),          cos(q(2)),        0];
% R3 =[cos(q(2) + q(3))*cos(q(1)), -sin(q(2) + q(3))*cos(q(1)),  sin(q(1));
%      cos(q(2) + q(3))*sin(q(1)), -sin(q(2) + q(3))*sin(q(1)), -cos(q(1));
%      sin(q(2) + q(3)),          cos(q(2) + q(3)),        0];
% R4 = [cos(q(2) + q(3) + q(4))*cos(q(1)), -sin(q(2) + q(3) + q(4))*cos(q(1)),  sin(q(1));
%      cos(q(2) + q(3) + q(4))*sin(q(1)), -sin(q(2) + q(3) + q(4))*sin(q(1)), -cos(q(1));
%      sin(q(2) + q(3) + q(4)),          cos(q(2) + q(3) + q(4)),        0];
% 
% Izz2 = (1/12)*m2*a2^2;
% Izz3 = (1/12)*m3*a3^2;
% Izz4 = (1/12)*m4*a4^2;
% I1 = [0, 0 , 0; 0 0 0 ; 0 0 0];
% I2 = [0, 0 , 0; 0 Izz2 0 ; 0 0 Izz2];
% I3 = [0, 0 , 0; 0 Izz3 0 ; 0 0 Izz3];
% I4 = [0, 0 , 0; 0 Izz4 0 ; 0 0 Izz4];

