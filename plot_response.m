function output = plot_response(fig_num, title_str, input_str, output_str, P_s, input, t)
% Plots the output of the given plant
% Parameters:
% fig_num - Number of the figure plotted
% p_title - Plot title
% P_s     - Plant transfer function
% input   - Input signal
% t       - time vector

output = lsim(P_s, input, t);
figure(fig_num);
plot(t, input, t, output);
title(title_str);
xlabel('time (t)');
ylabel('Angle (rad)');
legend(input_str, output_str);

end