%% PLOTS
close all;

%%
% Estrazione dati dalla simulazione per controllo di postura
e_out = squeeze(out.e_out.Data);
q_out = squeeze(out.q_out.Data);

des_A = zeros(size(q_out));
q_des_out = repmat(qd,1,size(q_out,2));

t_out = out.tout.';

% post process
res = 0.05;
[t_sim, q_sim] = adjust_time(t_out,q_out,res);
[~, q_sim_des] = adjust_time(t_out,q_des_out,res);

%% errors
f1 = figure;
f1.Position = ([2     2   681   616]);
hold on
grid
plot(t_out,e_out(1,:));
plot(t_out,e_out(2,:));
plot(t_out,e_out(3,:));
plot(t_out,e_out(4,:));
legend('$e_1$','$e_2$','$e_3$','$e_4$','Interpreter','latex')
title('Errors')

%% robot motion 3d
f2 = figure;
f2.Position = ([685     2   681   616]);
hold on
grid
axis equal

xlim([-10 10])
ylim([-10 10]) 
zlim([-10 10])
xlabel('X0')
ylabel('Y0')
zlabel('Z0')
view([6.0049 7.0443])
% view([-0.0642,2.4629])

title('Animation - PD or Computed torque')

% postura desiderata
% plot3(csi_des_out(1,:),csi_des_out(2,:),csi_des_out(3,:),'r','LineWidth',4)
legend ('Trajectory')
% initialize animation at time t0
ref_t = plot3(0,0,0,'-ko','linewidth',2);
exec_t = plot3(0,0,0,'-ko','linewidth',2); 
t_h = text(2.2,2.2,['(' num2str(0) ')']);

%%
for i=1:1:size(t_sim,2)
    
    delete(ref_t)
    delete(exec_t)
    delete(t_h)
    
    t_h = text(2.2,2.2,['(' num2str(t_sim(1,i)) ')']);
    ref_t=plot_robot(q_sim_des(:,i),[a1;a2;a3;a4],0); % variabili di giusto desiderate
    exec_t=plot_robot(q_sim(:,i),[a1;a2;a3;a4],1); % variabili di giunto controllate
    legend('reference','execution')
    
    drawnow
    
end