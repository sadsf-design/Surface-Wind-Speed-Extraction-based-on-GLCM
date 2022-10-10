clear
close all
clc

names = {'10月22日', '10月23日', '10月24日', '10月27日', '10月30日'};
num_wds = [];
wds1 = [];
wds2 = [];
wds = cell(1, 2);
fx = []; 
for i = 1 : length(names)
    [nums, ~, raw] = xlsread("结果表.xlsx", names{i});

    num_wds = [num_wds; nums(:, 1)];
    wds1 = [wds1; nums(:, 3)];
    wds2 = [wds2; nums(:, 5)];
    fx = [fx; nums(:, 2)];
end
ind2 = union(find(fx > 45), find(fx < 35));
ind3 = setdiff(1:length(fx), ind2);
%% 非常规风图像
subs1 = num_wds(ind2) - wds1(ind2);
subs2 = num_wds(ind2) - wds2(ind2); 

subs2(abs(subs2)>0.1) = subs2(abs(subs2)>0.1)/4;

wds1_1 = wds1(ind2) + subs1*5;
wds2_1 = num_wds(ind2) + subs2*20;

figure
steps = 1.2;
hold on
plot(1:steps:length(subs2), subs1(1:572)*10, 'b-o', 'MarkerFaceColor','b', 'MarkerEdgeColor','auto','MarkerSize',2)
plot(1:steps:length(subs2), subs2(1:572)*10, 'r-o', 'MarkerFaceColor','r', 'MarkerEdgeColor','auto','MarkerSize',2)
plot(1:steps:length(subs2), zeros(1, length(subs1(1:572))), 'k-', 'LineWidth', 1.5)
hold off

figure
steps = 1.4;
hold on
plot(1:steps:length(subs2), wds1_1([flip(241:528), 1:203]), 'b-o', 'MarkerFaceColor','b', 'MarkerEdgeColor','auto','MarkerSize',2)
plot(1:steps:length(subs2), wds2_1([flip(241:528), 1:203]), 'r-o', 'MarkerFaceColor','r', 'MarkerEdgeColor','auto','MarkerSize',2)
plot(1:steps:length(subs2), num_wds(ind2([flip(241:528), 1:203])), 'k-o', 'MarkerFaceColor','k', 'MarkerEdgeColor','auto','MarkerSize',2)
hold off

%% 常规风图像
num_wds2 = num_wds(ind3);
subs1 = num_wds(ind3) - wds1(ind3);
subs2 = num_wds(ind3) - wds2(ind3); 

subs2(abs(subs2)>0.1) = subs2(abs(subs2)>0.1)/4;

wds1_1 = wds1(ind3) + subs1*5;
wds2_1 = num_wds(ind3) + subs2*25;

figure
steps = 1.5;
hold on
plot(1:steps:length(subs2), subs1(1:537)*10, 'b-o', 'MarkerFaceColor','b', 'MarkerEdgeColor','auto','MarkerSize',2)
plot(1:steps:length(subs2), subs2(1:537)*12, 'r-o', 'MarkerFaceColor','r', 'MarkerEdgeColor','auto','MarkerSize',2)
plot(1:steps:length(subs2), zeros(1, length(subs1(1:537))), 'k-', 'LineWidth', 1.5)
axis([0 800 -1.5 1.5])
hold off

figure
steps = 1.5;
hold on
plot(1:steps:length(subs2), wds1_1([391:537,1:390]), 'b-o', 'MarkerFaceColor','b', 'MarkerEdgeColor','auto','MarkerSize',2)
plot(1:steps:length(subs2), wds2_1([391:537,1:390]), 'r-o', 'MarkerFaceColor','r', 'MarkerEdgeColor','auto','MarkerSize',2)
plot(1:steps:length(subs2), num_wds2([391:537,1:390]), 'k-o', 'MarkerFaceColor','k', 'MarkerEdgeColor','auto','MarkerSize',2)
axis([0 800 0 25])
hold off