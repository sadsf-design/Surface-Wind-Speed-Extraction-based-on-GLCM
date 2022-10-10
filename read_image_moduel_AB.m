clear
clc 
close all

root_name = './雷达数据图/';
load('ind.mat')
file_names = {'10_10_22/', '10_10_23/', '10_10_24/', '10_10_27/', '10_10_30/'};
% file_names = {'10_10_22/'};
f = {2};
ws_cell = cell(7, length(file_names));
% f = {1, 2, 3};
weights = {20, 10};
% o = 1;
wws = union(linspace(0.35, 3.5, 4), linspace(3.5, 35, 4));
deltas = union(linspace(0.008, 0.08, 4), linspace(0.08, 0.8, 4));
ww = 4;
dd = 4;
choice = 1; % 控制取消的是哪个模块，若为1，则取消去噪，若为2取消优化，若为0运行原版
% for dd = 1 : 7
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
                wss(j) = main_ws4(filename, index, f{o}, weights, wws(ww), deltas(dd), choice);
            end
            ws_cell{dd, i} = wss;
        end
    end
% end