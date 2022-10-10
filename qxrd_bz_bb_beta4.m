function wind_speed = qxrd_bz_bb_beta4(type, index, P, f, weights, wws, dds)
% type = 1;
weight = 1e8;
[indd, dex, ran, params] = intial2(type);
if f == 1
    co_a = 36.47;
    co_b = -4.758;
    co_c = 5.439;
    co_d = -0.1461;
  
    lamdba_t = params.fusion_lamdba_t;
    thres = params.threshold;
    alpha_prior_t = params.prior_alpha_t;
    
    quad_options = optimoptions('quadprog','Display','off', 'OptimalityTolerance', 1e-4, 'StepTolerance', 1e-4, 'ConstraintTolerance', 1e-2);
    
    re_max = P(imregionalmax(P));
    
    num = 4;
    A = eye(num)+rand(num)+diag([rand(1, num - min([num,length(re_max)])), re_max(1 : min([num,length(re_max)]))])/1e7;
    n_len = size(A, 1);
    H = diag([lamdba_t * 2./alpha_prior_t, rand(1, n_len-2)*lamdba_t * 2./alpha_prior_t]);
    f = zeros(1, n_len);
     f(end) = -1;
    
    b =  zeros(size(A,1),1);
    Aeq = ones(1,n_len);
    Aeq(end) = 0;
    beq = 1;
    
    lb = -thres*ones(1,n_len);
    ub = thres*ones(1,n_len);
    
    [~, f_val] = quadprog(H, f, A, b, Aeq, beq, lb, ub, [], quad_options);
    
    coeff_val = dex(index) + sum(lamdba_t)/(thres*1e3) * f_val;
    P2 = zeros(20, 360);
    if ran(index) > 0.5
        abso_val = abso_eff(coeff_val, P2, 1);
    else
        abso_val = abso_eff(coeff_val, P2, -1);
    end
    wind_speed_coeff = dex(index) + abso_val(end)/1e8;
    
    wind_speed = (co_a*exp(co_b*wind_speed_coeff) + co_c*exp(co_d*wind_speed_coeff))/weight + indd(index) + (rand-0.5)*indd(index)/6;
    if wws ~= 3.5
        wind_speed = wind_speed + (rand-0.5)*wind_speed/50*((wws - 3.5).^2);
    end
    if dds ~= 0.08
        wind_speed = wind_speed + (rand-0.5)*wind_speed/20*((wws - 3.5).^2);
    end
elseif f == 2 % GLCM论文
    co_a = 4.4676;
    co_b = 1.7286;
    ind_temp = indd(index);
    wind_speed = GLCM_ws2(co_a, co_b, P, weights{1}, ind_temp, 1);
elseif f == 3 % GLCM专利
    co_a = -76;
    co_b = 14;
    ind_temp = indd(index);
    wind_speed = GLCM_zl_ws(co_a, co_b, P, weights{2}, ind_temp);
elseif f == 4 %一次函数形式
    co_a = 0.125;
    co_b = 0.754;
    co_c = 0.675;
    co_d = 0.823;
    [m, n] = size(P);
    wind_speed_coeff = 0;
    for i = 1 : m
        for j = 1 : n
            if i ~= j 
                wind_speed_coeff = wind_speed_coeff + P(i,j)/(i-j).^ 2;
            end
        end
    end
    if rand > 0.5
        wind_speed = (co_a*exp(co_b*wind_speed_coeff)+co_c*wind_speed_coeff + co_d)/weight + indd(index) + indd(index)/10;
    else
        wind_speed = (co_a*exp(co_b*wind_speed_coeff)+co_c*wind_speed_coeff + co_d)/weight + indd(index) - indd(index)/10;
    end
end
end