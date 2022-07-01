function [Yp, Y] = compute_Y(table_dh, Jplink, Jolink, I, pc, z_dir )

syms t g m1 m2 m3 m4 q1 q2 q3 q4 dq1 dq2 dq3 dq4 real
syms a1 a2 a3 a4 real
% syms w2 w23 w24 w3 w34 w4 W2 W23 W24 W3 W34 W4 P122 P123 P124 P133 P134 P233 P144 P234 P244 P344

n = size(table_dh,1);
m = [m1,m2];
dq = [dq1; dq2];
q = [q1; q2];

if z_dir==1
    gvec = -g*[1,0,0]';
elseif z_dir==2
    gvec = -g*[0,1,0]';
elseif z_dir==3
    gvec = -g*[0,0,1]';
end

Tob_struct = T_world_body(table_dh);

% calcolo energia cinetica e potenziale per ogni link
T = cell(n,1);
U = cell(n,1);
% Yp = [];
T_tot = 0;
U_tot = 0;

for i=1:n
    % kinetic energy computation for each link
    Ri = Tob_struct{i}(1:3,1:3);
    Bi =  m(i)*Jplink{i}.'*Jplink{i} + Jolink{i}.'*Ri*I{i}*Ri.'*Jolink{i} ;
    Jvi = Jplink{i};
    Jwi = Jolink{i};
    T{i} = 1/2 * ( dq.'*Bi*dq );
    T_tot = T_tot + T{i};

    % potential energy computation for each link
    U{i}= - m(i) * gvec.' * pc{i};
    U_tot = U_tot + U{i};

end

L = T_tot - U_tot;

% time-derivative of dU/dqdot = 0. From Lagrangian equations :
% Yp_i = ( diff( diff( T{i}, dq ), t ) - diff( T{i}, q ) + diff( U{i}, q) ).';
% dLdqdot = jacobian(L,dq)
% dLdq = jacobian(L,q)
Yp = simplify(( diff( jacobian( L, dq ), t ) - jacobian( L, q )).');
Y = collect(Yp,[m1,m2])

% Yp = [Yp , Yp_i];
% dyn_pi = sym([m1;
%     m2;
%     m3;
%     m4;
%     (a2^2*m2)/12;
%     (a3^2*m3)/12;
%     (a4^2*m4)/12]);
%     -m4*(a1*cos(q1) + a3*cos(q2 + q3)*cos(q1) + a2*cos(q1)*cos(q2) + (a4*cos(q2 + q3 + q4)*cos(q1))/2);
%     -m4*(a3*sin(q2 + q3) + a2*sin(q2) + (a4*sin(q2 + q3 + q4))/2);
%     -m4*(a1*sin(q1) + a3*cos(q2 + q3)*sin(q1) + a2*cos(q2)*sin(q1) + (a4*cos(q2 + q3 + q4)*sin(q1))/2);
%     (a1^2*m1)/12;

%     (a1*m1*cos(q1))/2;
%     (a1*m1*sin(q1))/2;
%     -(a2*m2*sin(q2))/2;
%     -(a3*m3*sin(q2 + q3))/2;
%     -(a3*m3*cos(q2 + q3)*cos(q1))/2;
%     -(a3*m3*cos(q2 + q3)*sin(q1))/2;
%     -(a2*m2*cos(q1)*cos(q2))/2;
%     -(a2*m2*cos(q2)*sin(q1))/2]);
% size(dyn_pi)
% A = sym('a%d%d', [4 19]);
% A*dyn_pi
% Y = collect(Yp,dyn_pi);
% Y = solve(A*dyn_pi == Yp,A);
% size(Y)
% isqual (simplify(Yp),simplify[Y*dyn_pi))
% Y = equationsToMatrix(Yp,dyn_pi')
