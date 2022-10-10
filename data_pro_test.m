clear
clc

names = {'10月22日', '10月23日', '10月24日', '10月27日', '10月30日'};

ind = [];
dex = [];
indd = [];
thres = 0.07;
for i = 1 : length(names)
    [~, ~, raw] = xlsread('数据.xlsx', names{i});
    
    temp = raw(2:end, [1, 7]);
    dex_temp = zeros(size(temp, 1), 1);
    
    ind = [ind; temp(:, 1)];
    data_ws = cell2double(temp(:, 2));
    
    wei = data_ws /1e2 + thres*tanh(log(data_ws/5+1))+log(exp(data_ws/max(data_ws) +  1e-3*rand(length(data_ws), 1)) + exp(2))*thres;
%     wei = log(exp(data_ws/max(data_ws) +  1e-3*rand(length(data_ws), 1)) + exp(2)) * thres + data_ws/1e2 + exp(-tanh(data_ws));
%     wei = data_ws/1e2 + exp(-tanh(data_ws));
    indd = [indd; data_ws];
    dex = [dex; wei];
end
corrcoef(indd, dex)
% save('ind.mat', 'ind')
% save('dex.mat', 'dex')
% save('indd.mat', 'indd')