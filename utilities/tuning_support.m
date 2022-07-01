%% Tuning PD
close all
trials = 100; % numero di tentativi
research_range = 0.5:20;

for i=1:trials
    disp(['Trial number : ', num2str(i)])
    clear out k1 k2 k3 k4 Kp Kv
    k1 = research_range(randi(length(research_range)));
    k2 = research_range(randi(length(research_range)));
    k3 = research_range(randi(length(research_range)));
    k4 = research_range(randi(length(research_range)));
    Kp = diag([k1,k2,k3,k4]);
    Kv = Kp;

    disp(['Simulation for the trial ', num2str(i)])
    out = sim('TrajSim_pd_ct');
    % Estrazione dati dalla simulazione per inseguimento di movimento
    e_out = squeeze(out.e_out.Data);
    q_out = squeeze(out.q_out.Data);
    q_des_out = squeeze(out.q_des_out.Data);
    csi_des_out = squeeze(out.csi_des_out.Data);
    t_out = out.tout.';

    f1 = figure;
    f1.Position = ([2     2   681   616]);
    hold on
    grid
    plot(t_out,e_out(1,:));
    plot(t_out,e_out(2,:));
    plot(t_out,e_out(3,:));
    plot(t_out,e_out(4,:));
    legend('$e_1$','$e_2$','$e_3$','$e_4$','Interpreter','latex')
    title(['Tracking error with [k1 k2 k3 k4] = [' , num2str([k1,k2,k3,k4]), ']'])
end

% buone combinazioni
% [k1 k2 k3 k4] = [0  1  5  1]
% [k1 k2 k3 k4] = [8.5 1.5 11.5 9.5]
%  [k1 k2 k3 k4] = [0.5         11.5         17.5         13.5]
%  [k1 k2 k3 k4] = [11.5          1.5          4.5          7.5]
%  [k1 k2 k3 k4] = [18.5         18.5          9.5          9.5]
%  [k1 k2 k3 k4] = [10.5         19.5          1.5          8.5]