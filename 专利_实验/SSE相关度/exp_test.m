clear
close all
clc

co_a = 4;
co_b = 2;
x0 = 0.2 : 0.01 : 2;
y0 = co_a./x0 + co_b*x0;

x = [0.2 : 0.01 : 2, 0.2 : 0.01 : 2, 0.2 : 0.01 : 2, 0.2 : 0.01 : 2];
y = [0.95*y0 + (rand(1, length(y0)) - 0.5).*y0/20, (rand(1, length(y0)) - 0.5).*y0/20 + y0, (rand(1, length(y0)) - 0.5).*y0/20 + y0, 1.05*y0 + (rand(1, length(y0)) - 0.5).*y0/20];

x_d = 2 : 0.01 : 2.2;
x = [x, x_d, x_d];
x_d2 = 0.8:0.01:1;
y_d = flip((co_a./x_d2 + co_b*x_d2));
y = [y, (rand(1, length(y_d)) - 0.5).*y_d/10 + y_d, (rand(1, length(y_d)) - 0.5).*y_d/10 + y_d];

a = 36.47;
b = -4.758;
c = 5.439;
d = 0.04053;

y3 = 6.3;
x3 = 0.85;
y_m = sqrt((y - y3) .^ 2 + (x - x3) .^ 2);
[~, n] = sort(y_m);
n2 = flip(n);
y_m2 = ones(1, length(y_m));
x_ms2 = ones(1, length(y_m));
for i = 1 : length(y_m)
    y_m2(n(i)) = y_m(n2(i));
end
x0d = 0.17:0.01:2.2;
y0d = a*exp(b*x0d) + c*exp(d*x0d);
s = scatter(x, y, [], y_m2, "filled");
colormap jet
s.SizeData = 5;
hold on
plot(x0d, y0d, 'Color', [255,102,153]/255, 'LineWidth', 1.5)
%% 
figure
clear
clc

co_a = 4;
co_b = 2;
x0 = 0.2 : 0.01 : 2;
y0 = co_a./x0 + co_b*x0;
y02 = co_a./(0.2 : 0.1 : 2) + co_b*(0.2 : 0.1 : 2);

x = [0.2 : 0.01 : 2, 0.2 : 0.1 : 2];
y = [0.95*y0 + (rand(1, length(y0)) - 0.5).*y0/20, (rand(1, length(y02)) - 0.5).*y02/20 + y02];

x_d = 2 : 0.1 : 2.2;
x = [x, x_d, x_d];
x_d2 = 0.8:0.1:1;
y_d = flip((co_a./x_d2 + co_b*x_d2));
y = [y, (rand(1, length(y_d)) - 0.5).*y_d/10 + y_d, (rand(1, length(y_d)) - 0.5).*y_d/10 + y_d];

a = 36.47;
b = -4.758;
c = 5.439;
d = 0.04053;

y3 = 6.3;
x3 = 0.85;
y_m = sqrt((y - y3) .^ 2 + (x - x3) .^ 2);
[~, n] = sort(y_m);
n2 = flip(n);
y_m2 = ones(1, length(y_m));
x_ms2 = ones(1, length(y_m));
for i = 1 : length(y_m)
    y_m2(n(i)) = y_m(n2(i));
end
x0d = 0.17:0.01:2.2;
y0d = a*exp(b*x0d) + c*exp(d*x0d);
s = scatter(x, y, [], y_m2, "filled");
colormap winter
s.SizeData = 5;
hold on
plot(x0d, y0d, 'Color', [255,153,51]/255, 'LineWidth', 1.5)