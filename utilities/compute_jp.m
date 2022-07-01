function [Jplink, Jolink] = compute_jp(table_dh, pc)
%COMPUTE_JP computes the position jacobians for each link.
%   It works only for rotoidal joints

n = size(table_dh,1);
Jplink = cell(n,1);
Jolink = cell(n,1);
Tij_struct = cell(n,1);
Tob_struct = cell(n,1);
p = sym(zeros(3,n));
zb = sym(zeros(3,n));

% T0body and Origin of Body frames definition
for b=1:n
%     b
    Tij = dh(table_dh,b);
    Tij_struct{b}=Tij; % trasmormazione omogenea da {Sj} a {Si}
    if b>1
        Tob_struct{b}=Tob_struct{b-1}*Tij_struct{b}; % trasformazione omogenea da {Sb} a {S0}
        zb(:,b)=Tob_struct{b}(1:3,3);
        p(:,b) = simplify(Tob_struct{b-1}(1:3,end));
    else
        Tob_struct{1}=Tij_struct{1};
%         p(:,b) = simplify(Tob_struct{1}(1:3,end))
        zb(:,1)=[0 ; 0 ; 1];
    end
    
end
% size(p)
% p
for i =1:n
%     i
    Jpi = sym(zeros(3,n));
    Joi = sym(zeros(3,n));
    for j=1:i
        p(:,j);
        Jpi(:,j) = hat(zb(:,j))*(pc{i}-p(:,j));
%         Jpi;
        Joi(:,j) = zb(:,j);
%         Joi;
        Jolink{i}=Joi;
    end
    Jplink{i}=Jpi;
    
end




% syms a2 a3 a4 q1 q2 q3 q4
% global Jp1 Jp2 Jp3 Jp4 
% Jp1 = zeros(3,4);
% Jp2 = [ -a2/2*sin(q1)*cos(q2), a2/2*cos(q1)*sin(q2)  , 0 , 0;
%          a2/2*cos(q1)*cos(q2), -a2/2*sin(q1)*sin(q2) , 0 , 0;
%                 0            ,        cos(q2)        , 0 , 0];
% Jp3 = [-sin(q1)*a2*cos(q2)+a3/2*cos(q2+q3) , -cos(q1)*a2*sin(q2)+a3/2*sin(q2+q3) , -a3/2*cos(q1)*sin(q2+q3), 0;
%         cos(q1)*a2*cos(q2)+a3/2*cos(q2+q3) , -sin(q1)*a2*sin(q2)+a3/2*sin(q2+q3) , -a3/2*sin(q1)*sin(q2+q3), 0;
%               0       ,  a2*cos(q2)+a3/2*cos(q2+q3)        ,  a3/2*cos(q2+q3)        , 0];
% Jp4 = [-sin(q1)*a2*cos(q2)+a3*cos(q2+q3)+a4/2*cos(q2+q3+q4) , -cos(q1)*a2*sin(q2)+a3*sin(q2+q3)+a4/2*sin(q2+q3+q4) ,  -cos(q1)*a3*sin(q2+q3)+a4/2*sin(q2+q3+q4) , -cos(q1)*a4/2*sin(q2+q3+q4)
%         cos(q1)*a2*cos(q2)+a3*cos(q2+q3)+a4/2*cos(q2+q3+q4) , -sin(q1)*a2*sin(q2)+a3*sin(q2+q3)+a4/2*sin(q2+q3+q4) ,  -sin(q1)*a3*sin(q2+q3)+a4/2*sin(q2+q3+q4) , -sin(q1)*a4/2*sin(q2+q3+q4)
%                0       ,      a2*cos(q2)+a3*cos(q2+q3)+a4/2*cos(q2+q3+q4)    ,   a3*cos(q2+q3)+a4/2*cos(q2+q3+q4)         ,  a4/2*cos(q2+q3+q4)];
% 
% Jo1 = [0 , 0 , 0 , 0;
%        0 , 0 , 0 , 0;
%        1 , 0 , 0 , 0];
% Jo2 = [0 ,  sin(q1) , 0 , 0;
%        0 , -cos(q1) , 0 , 0;
%        1 ,     0    , 0 , 0];
% Jo3 = [0 ,  sin(q1) , sin(q1) , 0;
%        0 , -cos(q1) , -cos(q1), 0;
%        1 ,     0    ,    0    , 0];
% Jo4 = [0 ,  sin(q1) , sin(q1) ,  sin(q1);
%        0 , -cos(q1) , -cos(q1), -cos(q1);
%        1 ,     0    ,    0    ,   0];
% 
% R1 = [cos(q1), 0,  sin(q1);
%     sin(q1), 0, -cos(q1);
%       0, 1,        0];
% R2 = [cos(q1)*cos(q2), -cos(q1)*sin(q2),  sin(q1);
%       cos(q2)*sin(q1), -sin(q1)*sin(q2), -cos(q1);
%       sin(q2),          cos(q2),        0];
% R3 =[cos(q2 + q3)*cos(q1), -sin(q2 + q3)*cos(q1),  sin(q1);
%      cos(q2 + q3)*sin(q1), -sin(q2 + q3)*sin(q1), -cos(q1);
%      sin(q2 + q3),          cos(q2 + q3),        0];
% R4 = [cos(q2 + q3 + q4)*cos(q1), -sin(q2 + q3 + q4)*cos(q1),  sin(q1);
%      cos(q2 + q3 + q4)*sin(q1), -sin(q2 + q3 + q4)*sin(q1), -cos(q1);
%      sin(q2 + q3 + q4),          cos(q2 + q3 + q4),        0];
