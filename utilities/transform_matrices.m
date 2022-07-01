% MAIN PER MODELLARE IL MANIPOLATORE
syms q1 q2 q3 q4 a1 a2 a3 a4 m1 m2 m3 m4 

% tabella DH e matrice omogenea 

DH = [0  pi/2 0 q1 ; 
      a2   0  0 q2 ; 
      a3   0  0 q3 ; 
      a4   0  0 q4];

% DH = [a1   0  0 q1 ; 
%       a2   0  0 q2] ; 
table_dh = array2table(DH,'RowNames',{'Link 1', 'Link 2', 'Link 3', 'Link 4'},'VariableNames', {'ai', 'alphai', 'di', 'thetai'});

% table_dh = array2table(DH,'RowNames',{'Link 1', 'Link 2'},'VariableNames', {'ai', 'alphai', 'di', 'thetai'});

T01 = dh(table_dh,1);
T12 = dh(table_dh,2);
T23 = dh(table_dh,3);
T34 = dh(table_dh,4);

T02 = T01*T12;
T03 = T01*T12*T23;
T04 = T01*T12*T23*T34;

R01 = T01(1:3,1:3);
R02 = T02(1:3,1:3); 
R03 = T03(1:3,1:3);
R04 = T04(1:3,1:3);

pc0 = [0;0;0]; % posizione telaio
pc1 = pc0;
pc2 = [a2/2*cos(q2)*cos(q1);
    a2/2*cos(q2)*sin(q1);
    a2/2*sin(q2)];
pc3 = [(a2*cos(q2)+a3/2*cos(q2+q3))*cos(q1);
    (a2*cos(q2)+a3/2*cos(q2+q3))*sin(q1);
    a2*sin(q2)+a3/2*sin(q2+q3)];
pc4 = [(a2*cos(q2)+a3*cos(q2+q3)+a4/2*cos(q2+q3+q4))*cos(q1);
    (a2*cos(q2)+a3*cos(q2+q3)+a4/2*cos(q2+q3+q4))*sin(q1);
    a2*sin(q2)+a3*sin(q2+q3)+a4/2*sin(q2+q3+q4)];

pc=cell(4,1);
pc{1}=pc1;
pc{2}=pc2;
pc{3}=pc3;
pc{4}=pc4;

Jplink = compute_jp(table_dh, pc);