function T = dh(table_dh, i)

% trasformazione omogenea da link i-1 --> link i

thetai = table_dh.thetai(i,1); 
di = table_dh.di(i,1) ;
alphai = table_dh.alphai(i,1); 
ai = table_dh.ai(i,1) ;

T = [cos(thetai)  -cos(alphai)*sin(thetai)  sin(alphai)*sin(thetai) ai*cos(thetai); ...
     sin(thetai)   cos(alphai)*cos(thetai) -sin(alphai)*cos(thetai) ai*sin(thetai);
         0                 sin(alphai)            cos(alphai)                di;
         0                      0                       0                    1];

% Trz = [cos(thetai) -sin(thetai)  0 0;
%        sin(thetai)  cos(thetai)  0 0;
%             0           0        1 0;
%             0           0        0 1];
% 
% Ttz = [ 1 0 0 0;
%         0 1 0 0;
%         0 0 1 di;
%         0 0 0 1];
% 
% Ttx = [ 1 0 0 ai;
%         0 1 0 0;
%         0 0 1 0;
%         0 0 0 1];
% 
% Trx = [ 1      0            0      0;
%         0 cos(alphai) -sin(alphai) 0;
%         0 sin(alphai)  cos(alphai) 0;
%         0      0            0      1];
% 
% T = Trz*Ttz*Ttx*Trx;

