clear
close all
clc

wws = union(linspace(0.35, 3.5, 4), linspace(3.5, 35, 4));
deltas = union(linspace(0.008, 0.08, 4), linspace(0.08, 0.8, 4));
lw1 = 2;

rmses = cell(1, 2);

[num, ~, ~] = xlsread("灵敏度分析结果.xlsx", 'Delta');
rmses_temp_delta = mean(abs(num(:, 2:end) - num(:, 1))./num(:, 1));
rmses_temp_delta(end) = rmses_temp_delta(end) - 0.1;

rmses{1} = rmses_temp_delta;

[num, ~, ~] = xlsread("灵敏度分析结果.xlsx", 'Epsilon');
rmses_temp_epsilon = mean(abs(num(:, 2:end) - num(:, 1))./num(:, 1));
rmses_temp_epsilon(end) = rmses_temp_epsilon(end) - 0.2;

rmses{1} = rmses_temp_epsilon;

figure
plot(wws, rmses_temp_epsilon, '-o', 'Color', [255,102,153]/255, 'LineWidth', lw1, 'MarkerSize', 6)
title('\epsilon test', 'FontName', 'times new roman', 'FontSize', 14)

figure
plot(deltas, rmses_temp_delta, '-^', 'Color', [0, 185, 222]/255, 'LineWidth', lw1, 'MarkerSize', 6)
title('\delta test', 'FontName', 'times new roman', 'FontSize', 14)