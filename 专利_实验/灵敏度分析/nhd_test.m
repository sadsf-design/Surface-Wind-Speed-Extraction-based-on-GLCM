clear
close all
clc

wws = union(linspace(0.35, 3.5, 4), linspace(3.5, 35, 4));
deltas = union(linspace(0.008, 0.08, 4), linspace(0.08, 0.8, 4));

y_deltas = 0.1 .* (0.08./abs(deltas) + 0.08.*abs(deltas))/2;
y_wws = 0.0046 .* (3.5./abs(wws) + 3.5.*(wws))/2;