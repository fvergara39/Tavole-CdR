function [t_sim,q_sim] = adjust_time(t_out,q_out,res)
% ADJUST TIME Adjusts time vector in order to have a realistic animation in
% time

% Creating good time vector
t_f = t_out(end);
t_0 = t_out(1);
t_sim = t_0:res:t_f;
size(t_sim,2)
% Getting the nearest values in q_sim
q_sim = zeros(size(q_out,1), size(t_sim,2)); % preallocating
for i = 1:size(t_sim,2)
    [~, index] = min(abs(t_out - t_sim(i))) % getting index of nearst element
    q_sim(:,i) = q_out(:,index);
end


