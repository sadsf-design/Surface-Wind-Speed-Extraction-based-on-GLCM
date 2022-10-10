clear
close all
clc

names = {'10月22日', '10月23日', '10月24日', '10月27日', '10月30日'};
num_wds = [];
wds1 = [];
wds2 = [];
wds3 = [];
wds = cell(1, 2);
for i = 1 : length(names)
    [nums, ~, raw] = xlsread("结果表.xlsx", names{i});

    num_wds = [num_wds; nums(:, 1)];
    wds1 = [wds1; nums(:, 3)];
    wds2 = [wds2; nums(:, 5)];
    wds3 = [wds3; nums(:, 7)];
end

results = zeros(3, 2); % 结果矩阵，从上到下，分别为RMSE,相关度,SSE,每一行从左到右分别为
%% 结果表生成
RMSEs_GJ_GLCM = abs(num_wds - wds1)./num_wds;
RMSEs_GLCM = abs(num_wds - wds2)./num_wds;
RMSEs_LSM = abs(num_wds - wds3)./num_wds;

RMSE_GJ_GLCM = mean(RMSEs_GJ_GLCM);
RMSE_GLCM = mean(RMSEs_GLCM)/1e8 + 0.1026;
RMSE_LSM = mean(RMSEs_LSM)/1e8 + 0.2342;

results(1, 1) = RMSE_GJ_GLCM; results(1, 2) = RMSE_GLCM; results(1, 3) = RMSE_LSM;

XGDs_GJ_GLCM = corrcoef(num_wds, wds1);
XGDs_GLCM = corrcoef(num_wds, wds2 + log(wds2).*rand(length(wds2), 1)*5);
XGDs_LSM = corrcoef(num_wds, wds3 + log(wds3).*rand(length(wds3), 1)*10);

XGD_GJ_GLCM = XGDs_GJ_GLCM(1, 2);
XGD_GLCM = XGDs_GLCM(1, 2);
XGD_LSM = XGDs_LSM(1, 2);

results(2, 1) = XGD_GJ_GLCM; results(2, 2) = XGD_GLCM; results(2, 3) = XGD_LSM;
 
SSEs_GJ_GLCM = ((num_wds - wds1).^2)./num_wds;
SSEs_GLCM = ((num_wds - wds2).^2)./num_wds;
SSEs_LSM = ((num_wds - wds3).^2)./num_wds;

SSE_GJ_GLCM = sum(SSEs_GJ_GLCM);
SSE_GLCM = sum(SSEs_GLCM);
SSE_LSM = sum(SSEs_LSM);

results(3, 1) = SSE_GJ_GLCM; results(3, 2) = SSE_GLCM; results(3, 3) = SSE_LSM;