% PVTOL Dynamics equations
% x : horizontal position of the aircraft cdm
% y : vertical position of the aircraft cdm
% theta : roll angle of th aircraft wrt the horizon
 % u1 : thrust directed out of the bottom of the aircraft
 % u2 : angular acceleration - rolling moment
 % d : parameter of coupling between the rolling moment and the lateral acceleration
 % -1 : normalized gravitational acceleration
% syms theta(t) 
% 
%  u \in Rm m = 2
%  x \in Rn n = 3
%
%  Basic equations of motion : (Hauser et al., 1992)
% x_ddot = -sin(theta)*u1 + d*cos(theta)*u2;
% y_ddot = cos(theta)*u1 + d*sin(theta)*u2 - 1;
% theta_ddot = u2;

% Si considera x e y come uscite misurabili, dato che theta è difficile da misurare sul sistema reale

syms u1 u2
z1 = sym('z1','real');
z2 = sym('z2','real');
z3 = sym('z3','real');
z4 = sym('z4','real');
z5 = sym('z5','real');
z6 = sym('z6','real');
z = [z1,z2,z3,z4,z5,z6].';
%(z1, z2, z3, z4, z5, z6) = (x, y, θ, x_dot, y_dot, θ_dot)

f = [z2 0 z4 0 z6 0].';
g = [0 -sin(z5) 0  cos(z5) 0 1].';
n = numel(f);

% c = [1 0 0 0 0 0;
%      0 1 0 0 0 0]; % misura x e y
%% Equilibrium

vtol_equilibrium

% (states,controls) := [x,x_dot,y,y_dot,theta,theta_dot,u1,u2].'
%   := [z1,z2,z3,z4,z5,z6,u1,u2].'
pde = [0,0,0,0,0,0,1,0].';
%% Accessibility - not accessible 
% Verifying accessibility - necessary and sufficient condition
% CHOW 'S THEOREM : smallest D-invariant distribution containing D0 , i.e  
% accessibility distribution is <D,D0> = n in x0 => stla
% Delta0 = span(g1,..,gd)
% Delta = span(f,g1,..,gd)
vars = z;
vars0 = pde(1:6);
[Delta_th,span_k, k] = filtration_pde(f,g,vars,vars0);
if span_k(k)==n 
    disp('The system is small-time locally accesible')
else
    disp(['The set of points reachable from x0 is contained in a subManifold' ...
        'of dimension r = ',num2str(span_k(k)) ,' < n = ',num2str(n)])
end

%% Local Weak Controllability - not involutive
% Necessary condition to have local weak controllability is that involutive 
% closure of Delta(x) spans the whole state space
[k_c, r_c] = filtration(Delta,Delta);
if r_c==n 
    disp('The system is locally weakly controllable')
else
    disp('We cannot say wheter the system is locally weakly controllable or not')
end

%% From Accessibility to Controllability
% Accessibility is necessary for controllability, but not sufficient
% condition
% i) f(x) = 0 in the neighborhood of x0 - driftless system
f
f_x0 = subs(f,z,vars0) % no

% Bx0 = x0 + randi([-0.5 0.5],n,1);
% f_Bx0 = subs(f,x,Bx0);
% if f_Bx0==zeros(size(f)) 
%     disp('First condition satisfied')
% else
%     disp('First condition not satisfied')
% end

% ii) f(x) \in span{g1,...,gd}  in the neibourhood of x0
G_Bx0 = subs(G,x,Bx0); % SI PERCHé C'é SIN E COS
flag = is_in_span(f_Bx0,G_Bx0);

% iii) f(x0) = 0 and dim DeltaL(x0)=n
% DeltaL = span{gi,[f,gi],...,adf_mui_gi,..}



