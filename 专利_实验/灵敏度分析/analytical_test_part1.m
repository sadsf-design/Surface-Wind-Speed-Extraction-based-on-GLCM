clear
close all
clc

wws = union(linspace(0.35, 3.5, 4), linspace(3.5, 35, 4));
deltas = union(linspace(0.008, 0.08, 4), linspace(0.08, 0.8, 4));
lw1 = 2;

rmses = cell(1, 2);

[num, ~, ~] = xlsread("灵敏度分析结果.xlsx", '灵敏度分析');
rmses_temp_A = mean(abs(num(:, 2) - num(:, 1))./num(:, 1));
% rmses_temp_A(end) = rmses_temp_delta(end) - 0.1;

rmses{1} = rmses_temp_A;

rmses_temp_B = mean(abs(num(:, 3) - num(:, 1))./num(:, 1));
% rmses_temp_epsilon(end) = rmses_temp_epsilon(end) - 0.2;

rmses{2} = rmses_temp_B;

[num, ~, ~] = xlsread("灵敏度分析结果.xlsx", 'Delta');
rmses_temp_C = mean(abs(num(:, 5) - num(:, 1))./num(:, 1));

figure
plot([rmses_temp_A, rmses_temp_C, rmses_temp_B], '-o', 'Color', [255,102,153]/255, 'LineWidth', lw1, 'MarkerSize', 6)
title('analytical test', 'FontName', 'times new roman', 'FontSize', 14)