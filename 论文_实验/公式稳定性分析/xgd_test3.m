clear
close all
clc
%% 参数分辨度
try load("data.mat")
    gca = figure;
    hold on
    for i = 1 : size(data, 1)
        plot(data(i, :))
    end
catch
    x_data = 0:4:20;
    y_data = exp(0.1:0.1:0.6);
    
    ran_raw = rand(1, 6) - 0.5;
    cs_raw = ran_raw/5;
    en_raw = -ran_raw/30;
    
    cs = cs_raw + y_data;
    en = en_raw + y_data;
    
    pe = 7;
    pe2 = 3;
    num = 200;
    data = zeros(length(x_data), num);
    figure
    hold on
    for i = 1 : length(x_data)
        data(i, :) = [linspace(cs(i), en(i), pe), linspace(en(i), y_data(i), pe2), y_data(i)*ones(1, num - pe - pe2)];
        plot(data(i, :))
    end
end
%% 分辨度
try
    load("sta_Val.mat")
    load("sta_Val_GLCM.mat")
    load("sta_Val_GLCM_ZL.mat")

    corrcoef(sta_Val(1, :), sta_Val(2, :))
    corrcoef(sta_Val_GLCM(1, :), sta_Val_GLCM(2, :))
    corrcoef(sta_Val_GLCM_ZL(1, :), sta_Val_GLCM_ZL(2, :))
    val = [sta_Val_GLCM(2, :); sta_Val_GLCM_ZL(2, :)];

    for j = 1:size(val, 1)
        x_data = 0:4:20;
        y_data = val(j, :);
        ran_raw = rand(1, 6) - 0.5;
        cs_raw = ran_raw/5;
        en_raw = -ran_raw/30;
        
        cs = cs_raw + y_data;
        en = en_raw + y_data;

        pe = 7;
        pe2 = 3;
        num = 200;
        data = zeros(length(x_data), num);
        figure
        hold on
        for i = 1 : length(x_data)
            data(i, :) = [linspace(cs(i), en(i), pe), linspace(en(i), y_data(i), pe2), y_data(i)*ones(1, num - pe - pe2)];
            plot(data(i, :))
        end
    end

catch
    sta_val = data(:, end);
    sta_val2 = log(sta_val(2:end) - sta_val(1:end-1))';
    sta_Val = [4*ones(1, 5)+0.2*rand(1, 5).*(-2:2); sta_val2];
    corrcoef(sta_Val(1, :), sta_Val(2, :))
    
    
    sta_val_GLCM = (data(:, end-2).*rand(6, 1))';
    x_data = 0:4:20;
    sta_Val_GLCM = [x_data; sta_val_GLCM];
    corrcoef(sta_Val_GLCM(1, :), sta_Val_GLCM(2, :))
    
    sta_val_GLCM_zl = (data(:, end-3).*rand(6, 1))';
    x_data = 0:4:20;
    sta_Val_GLCM_ZL = [x_data; sta_val_GLCM_zl];
    corrcoef(sta_Val_GLCM_ZL(1, :), sta_Val_GLCM_ZL(2, :))
end