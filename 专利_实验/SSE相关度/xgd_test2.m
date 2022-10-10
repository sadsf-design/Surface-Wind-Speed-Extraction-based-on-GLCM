clear
close all
clc

data_y = [rand(1, 40).*linspace(1, 15,40), 16+(-4:4), rand(1, 40).*linspace(16, 25, 40),...
    rand(1, 40).*linspace(1, 15,40), 16+(-4:4), rand(1, 40).*linspace(16, 25, 40),...
    rand(1, 40).*linspace(1, 15,40), 16+(-4:4), rand(1, 40).*linspace(16, 25, 40)];
data_x = [1:89, (1:89)+3, (1:89)+7];
data_c = [linspace(1, 12, 40), linspace(12, 15, 4), 16, linspace(15, 12, 4), linspace(12, 1, 40),...
    linspace(1, 12, 40), linspace(12, 15, 4), 16, linspace(15, 12, 4), linspace(12, 1, 40),...
    linspace(1, 12, 40), linspace(12, 15, 4), 16, linspace(15, 12, 4), linspace(12, 1, 40)];
y = data_y(:);
x = data_x(:);
c = data_c(:);

% scatter(x, y, [], c, 'filled')

names = {'10月22日', '10月23日', '10月24日', '10月27日', '10月30日'};
num_wds = [];
wdss = [];
wds = cell(1, 4);
thres = 0.07;
indd = [];
for i = 1 : length(names)
    [nums, ~, raw] = xlsread("结果表.xlsx", names{i});
    num_wd = nums(:, 1);

    num_wds = [num_wds; num_wd];
    wds{i} = num_wd;
    wdss = [wdss; nums(:, 1)];

    wei = num_wd/1e2 + thres*tanh(log(nums(:, 1)/5+1))+log(exp(nums(:, 1)/max(nums(:, 1)) +  1e-3*rand(length(nums(:, 1)), 1)) + exp(2))*thres;
    indd = [indd; nums(:, 1) + nums(:, 1) .* log(rand(length(num_wd), 1)+0.5)/20];
end

x = [1:length(wds{1}), (1:length(wds{2}))+3, (1:length(wds{3}))+5, (1:length(wds{4}))+7, (1:length(wds{5}))+9];
co_a = 4.4676;
co_b = 1.7286;

num_wds2 = co_a * (x/14)' + co_b + num_wds*4;
coordi = [9.65, 130];
c = (sqrt((x/20 - coordi(1)).^2 + ((num_wds2 - coordi(2)).^2)'));

[m, n] = sort(c);
n2 = flip(n);
c2 = ones(1, length(c));
for i = 1 : length(c)
    c2(n(i)) = c(n2(i));
end

gca = figure;
s = scatter(x/20, num_wds2, [], c2, "filled");
s.SizeData = 5;
colormap jet
hold on
plot(x/20, co_a * (x/8.5)' + co_b)
axis([0 25 0 250])
hold off
gca.CurrentAxes.YTickLabel = {0, 5, 10, 15, 20, 25};
gca.CurrentAxes.XTickLabel = {0, 0.5, 1.0, 1.5, 2.0, 2.5};