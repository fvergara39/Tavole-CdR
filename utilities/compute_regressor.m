function [Y , piDyn] = compute_regressor(table_dh, Jplink, Jolink, I, p_ig, z_dir )
% COMPUTE_Y computes the regressor matrix
%  table_dh is the Denavit Hartenberg matrix
%  I is the structure of the intertial tensors for each link, expressed in body frame
%  P_ig is the position vector from the origin of the body frame to the baricenter of the link
%  z_dir is the direction of the Spatial frame ( rightward : 1 inward : 2  up: 3)

% Initialization

syms q1(t)  q2(t)  q3(t)  q4(t)  dq1(t)  dq2(t)  dq3(t)  dq4(t)
dq = [dq1 dq2].';
% q = [q1 q2].';
q=[str2sym('q1(t)'),str2sym('q2(t)')];
q(2)
q(1)

syms a1 a2 a3 a4 g m1 m2 m3 m4 real

% n =2;
n = size(table_dh,1);
m =sym('m',[1,n]);
% m = sym('m',[n 1]);
% dq  = sym('dq',[n 1]);
% q  = sym('q',[n 1]);

% Future total regressor matrix and dynamic params vector
Y = [];
piDyn = [];

% Initialize
if z_dir==1
    gvec = -g*[1,0,0]';
elseif z_dir==2
    gvec = -g*[0,1,0]';
elseif z_dir==3
    gvec = -g*[0,0,1]';
end

Tob_struct = T_world_body(table_dh);

E1 = [1 0 0;0 0 0;0 0 0];
E2 = [0 1 0; 1 0 0; 0 0 0];
E3 = [0 0 1; 0 0 0; 1 0 0];
E4 = [0 0 0; 0 1 0; 0 0 0];
E5 = [ 0 0 0; 0 0 1; 0 1 0];
E6 = [0 0 0; 0 0 0; 0 0 1];
E =  {E1 , -E2 , -E3 , E4 , -E5 , E6};

% Idea
% elements from diff(diff( T_i , d qdot ) , t ).'
%         add1 = dX0_i * pi0_i + dX1_i * pi1_i + dX2_i * pi2_i;

% elements from diff( T_i , q ).'
%         add2 = W0_i * pi0_i + W1_i * pi1_i + W2_i * pi2_i;

% elements from diff( U , q )
%         add3 = Z0_i * pi0_i + Z1_i * pi1_i;

%% diff(diff( T_i , d qdot ) , t ) - diff( T_i , q ) + diff( U , q ) .' = Y * pi

% prepare dynamic parameters vector
% per ogni link i-esimo, vengono calcolatii i tre vettori pi

for i=1:n
    I_i=I{i};
    pi0_i = m(i); % nx1
    pi1_i = m(i)*p_ig{i}; % 3x1
    pi2_i = [I_i(1,1),-I_i(1,2),-I_i(1,3), I_i(2,2),-I_i(2,3), I_i(3,3)].'; % 6x1

    Ri = Tob_struct{i}(1:3,1:3);
    Jvi = Jplink{i};
    Jwi = Jolink{i};

    %% diff(diff( T_i , d qdot ) , t ).' = dX0_i * pi0_i + dX1_i * pi1_i + dX2_i * pi2_i
    % Find X0 X1 X2 for the i_th link
    X0_i = Jvi.'*Jvi*dq; % nx1
    X1_i = (Jvi.'*hat(Jwi*dq(t)) - Jwi.'*hat(Jvi*dq(t))) * Ri; % nx3
    X2_i = sym(zeros(n,6)); % nx6
    for j=1:6
        %         Jwi.'*Ri*E{j}*Ri.'*Jwi*dq
        X2_i(1:n,j) = Jwi.'*Ri*E{j}*Ri.'*Jwi*dq;
    end

    dX0_i = diff (X0_i , t);
    dX1_i = diff (X1_i , t);
    dX2_i = diff (X2_i , t);

    %% diff( T_i , q ).' = W0_i * pi0_i + W1_i * pi1_i + W2_i * pi2_i
    % Find W0 W1 W2 for the i_th link

    A = Jvi.'*Jvi;
    B = Ri.'*(hat(Jwi*dq(t))).'*Jvi*dq - Ri.'*(hat(Jvi*dq(t))).'*Jwi*dq;

    for w=1:n

        mult_0{w} = diff( A, q(w) );
        W0_i(w,:) = 1/2 * dq.'*mult_0{w}*dq;

        mult_1{w} = diff( B, q(w) );
        W1_i(w,:) = 1/2 *mult_1{w};

    end

    for e=1:6
        for t=1:n
            C = Jwi.'*Ri*E{e}*Ri.'*Jwi;

            mult_2{t} = diff( C, q(t) );
            W2_i(t,e) = 1/2 * dq.'*mult_2{t}*dq;

        end
    end
    size(W0_i)
    size(W1_i)
    size(W2_i)

    %% diff( U , q ) = Z0_i * m_i + Z1_i * m_i * p_ig
    % Find Z0 Z1 Z2 for the i_th link

    Z0_i = - Jvi.'*gvec;
    Z1_i = sym(zeros(n,3));
    med_mat3 = (Ri.'*gvec).';
    for r=1:n % riga per riga
        for z=1:3 % colonna
            Z1_i(r,z) = - diff( med_mat3(:,z) , q(r) ).';
        end
    end

    %% Assembly in regressor matrix and dynamic params vector

    Y0_i = dX0_i - W0_i + Z0_i;
    Y1_i = dX1_i - W1_i + Z1_i;
    Y2_i = dX2_i - W2_i; %+ Z2_i;

    Y_i= [Y0_i , Y1_i , Y2_i];
    piDyn_i = [pi0_i ; pi1_i ; pi2_i];

    Y = [ Y , Y_i];
    piDyn = [piDyn ; piDyn_i];
end

Y = simplify(Y);
piDyn = simplify(piDyn);
