function [amount, stack, label] = connect4_theta(mIn, sta, las, sta_theta,las_theta)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
[m, n] = size(mIn);%��ȡ����ͼƬ����������
label = ones(m, n);%labels����������������ǩ�Ĳ���
% stack = zeros(2, m*n);%��ջ���飬�����������Ҫ���
% sta = 566;
% las = 600;
% sta = 475;
% las = 500;
gap = 2;
scale = (1:las-sta+gap);

% sta_theta = 120;
% las_theta = 180;

theta = sta_theta:las_theta;
stack = zeros(2, length(scale)*length(theta));%��ջ���飬�����������Ҫ���
top = 0;%��ջָ��
count = 0;%������
amount = zeros(10000, 1);%����ÿһ������Ĵ�С
TuCou = 0; %�����С������
for i1 = scale
    for j1 = theta
        i = sta + round(i1 * sind(j1));
        j = sta + round(i1 * cosd(j1));
        TuCou = 0;
        if (mIn(i, j) == 0) && (label(i,j) == 1)
            count = count + 1;
            top = top + 1;
            stack(1, top) = i;
            stack(2, top) = j;
            label(i, j) = 0;
            TuCou = TuCou + 1;
        end
        in = i;
        jn = j;
        while top ~= 0
            in = stack(1, top);
            jn = stack(2, top);
            if in <= 0 || in - 1 <= 0
                break;
            end
            if jn <= 0 || jn - 1 <= 0
                break;
            end
            if jn > n || jn + 1 > n
                break;
            end
            if in > m || in + 1 > m
                break;
            end
            top = top - 1;
            if (mIn(in - 1, jn) == 0) && (label(in - 1, jn) == 1)
                top = top + 1;
                stack(1, top) = in - 1;
                stack(2, top) = jn;
                label(in - 1, jn) = 0;
                TuCou = TuCou + 1;
            end
            if (mIn(in + 1, jn) == 0) && (label(in + 1, jn) == 1)
                top = top + 1;
                stack(1, top) = in + 1;
                stack(2, top) = jn;
                label(in + 1, jn) = 0;
                TuCou = TuCou + 1;
            end
            if (mIn(in, jn - 1) == 0) && (label(in, jn - 1) == 1)
                top = top + 1;
                stack(1, top) = in;
                stack(2, top) = jn - 1;
                label(in, jn - 1) = 0;
                TuCou = TuCou + 1;
            end
             if (mIn(in, jn + 1) == 0) && (label(in, jn + 1) == 1)
                top = top + 1;
                stack(1, top) = in;
                stack(2, top) = jn + 1;
                label(in, jn + 1) = 0;
                TuCou = TuCou + 1;
             end
        end
        if count ~= 0 && TuCou > amount(count)
            amount(count) = TuCou;
        end
    end
end
number = count;


end

