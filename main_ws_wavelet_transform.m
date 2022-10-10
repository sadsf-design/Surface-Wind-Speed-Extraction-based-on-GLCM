function wind_speed = main_ws_wavelet_transform(filename, index, f, weights)
% Parameters
w1 = 0.25;
w2 = 0.75;

warning('off')

inputIm = imread(filename);

type = 1;

% 读图片
a = inputIm(:,:,1);
b = inputIm(:,:,2);
c = inputIm(:,:,3);

% 根据像素值，提取趋势+预处理
for k1 = 1:size(inputIm, 1)
    for k2 = 1:size(inputIm, 2)
        if a(k1,k2)==b(k1,k2)
            if b(k1,k2)==c(k1,k2)
                a(k1,k2) = 255;
                b(k1,k2) = a(k1,k2);
                c(k1,k2) = b(k1,k2);
            end
        end
    end
end
ina = find(a(:)<150);
inb = find(b(:)<150);
inc = find(c(:)<150);
in = intersect(intersect(ina,inb),inc);

a(in)=a(in+size(inputIm,2));
b(in)=b(in+size(inputIm,2));
c(in)=c(in+size(inputIm,2));

ina = find(a(:)>200);
inb = find(b(:)>200);
inc = find(c(:)>200);
in = intersect(intersect(ina,inb),inc);

a(in)=255;
b(in)=255;
c(in)=255;

% ina = find(a(:)>200);
% inb = find(b(:)>170);
% inc = find(c(:)<100);
% in = intersect(intersect(ina,inb),inc);
% b(in)=3;
% c(in)=3;

% ina = find(a(:)>120);
% inb = find(b(:)<220);
% inc = find(c(:)<120);
ina = find(a(:)<=255);
inb = find(b(:)<230);
inc = find(c(:)>150);
in = intersect(intersect(ina,inb),inc);
for l = 1:(size(a,1)*size(a,2))
    if ~isempty(find(in==l, 1))
        a(l)=255;
        b(l)=255;
        c(l)=255;
%     else
%         b(l)=3;
%         c(l)=3;
    end
end

% inputIm2 = cat(3,a,b,c);
inputIm2 = cat(3,a,b,c);

% 图像特征提取
inputIm = rgb2gray(inputIm2);
inputIm = im2double(inputIm);


% wavelet transform
level = 1; % 小波水平
h=[0.48296 0.83652 0.22414 -0.12941]; % 小波参数
wave_dec = multiwaveletdecomposition(inputIm, h, level); % 小波分解1

noise_level=[wave_dec(floor(size(wave_dec, 1)/2)+2:size(wave_dec, 1),1:floor(size(wave_dec, 2)/2)) wave_dec(floor(size(wave_dec, 1)/2):size(wave_dec, 1)-2,floor(size(wave_dec, 2)/2):size(wave_dec, 2)) wave_dec(1:floor(size(wave_dec, 1)/2),floor(size(wave_dec, 2)/2):size(wave_dec, 2))];
Variance=median(abs(noise_level(:)))/0.6745;

threshold=10*Variance;

hthres=wave_dec.*((abs(wave_dec)>threshold));% 小波分解1，对应P(Ie)
sthres=(sign(wave_dec).*(abs(wave_dec)-threshold)).*((abs(wave_dec)>threshold)); % 小波分解2，对应Q(Ie)

imrech = multiwaveletreconstruction(w1*hthres + w2*sthres, h, level); % 小波分解的融合

imrech_inverse = invers_z_transformation([imrech, imrech;imrech, imrech], inputIm2); % 逆Z变换

sta = 300;
las = 500;
sta_theta = 0;
las_theta = 180;
[~, ~, label] = connect4_theta(im2double(rgb2gray(imrech_inverse)), sta, las, sta_theta,las_theta);

[M,N]=size(label);
    
r_sta = 402;
r_las = 637;
c_sta = 338;
c_las = 776;

index2 = 2;

step1 = 180;
step2 = 0.1;
step3 = 0.01;

thres = 2; % 总灰度范围
iters = 1;

    
for itration = 1 : iters
     if itration == 1
         theta = 0:step1:180;
     end
     if itration == 2
         theta = theta(theta2) + (-step1:step2:step1);
     end
     if itration == 3
         theta = theta(theta2) + (-step2:step3:step2);
     end
     if itration > 1
         theta(theta<0) = 0;
         theta(theta>180) = 180;
     end

     rmax = 1;

     %计算灰度共生矩阵P
     P2=zeros(thres,thres,rmax,length(theta));
     Q2=zeros(rmax,length(theta));
     for m=index2
         for n=index2
             for i=r_sta:r_las
                 for j=1:c_sta:c_las
                     for r=1:rmax
                         for t = 1:length(theta)
                             if (i+round(r*sind(theta(t))) <= M) && (i+round(r*sind(theta(t))) > 0)...
                                 && (j+round(r*cosd(theta(t))) <= N) && j+round(r*cosd(theta(t))) > 0
                                 Q2(r,t) = Q2(r,t) + 1;
                                 if (label(i,j)==m-1) && (label(i+round(r*sind(theta(t))),j+round(r*cosd(theta(t))))==n-1)
                                     P2(m,n,r,t)=P2(m,n,r,t)+1;
                                     P2(n,m,r,t)=P2(m,n,r,t);
                                 end
                             end
                         end
                     end
                 end
             end
         end
     end
     P = upqp(P2, Q2, index);
     % 加入后续的风速
     wind_speed = qxrd_bz_bb_beta2(type, index, P, f, weights);
end
end