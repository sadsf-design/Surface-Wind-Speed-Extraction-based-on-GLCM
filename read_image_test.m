clear
clc 
close all

root_name = './雷达数据图/';
load('ind.mat')
file_names = {'10_10_22/', '10_10_23/', '10_10_24/', '10_10_27/', '10_10_30/'};
% file_names = {'10_10_22/'};
f = {1, 2, 3};
ws_cell = cell(length(f), length(file_names));
% f = {1, 2, 3};
weights = {20, 10};
% o = 1;
for o = 1 : length(f)
    for i = 1 : length(file_names)
        name = [root_name, file_names{i}];
        list_name = [name, 'list.txt'];
        
        list = [];
        fid=fopen(list_name);
        while ~feof(fid)    % while循环表示文件指针没到达末尾，则继续
            % 每次读取一行, str是字符串格式
            str = fgetl(fid);
    
            list = [list; str];
        end
        
        wss = zeros(1, length(list));
        for j = 1 : length(list)
            filename_temp = list(j, :);
            for k = 1 : length(ind)
                ind_temp = ind{k};
                flag = strcmp(ind_temp(6:end), filename_temp(1:end-7));
                if flag == 1
                    index = k;
                    break
                end
            end
            filename = [name, list(j, :)];
            wss(j) = main_ws_wavelet_transform(filename, index, f{o}, weights);
        end
        ws_cell{o, i} = wss;
    end
end