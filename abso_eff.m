function abso_val = abso_eff(coeff_val, P, flag)
[m, n] = size(P);
Dis_mat = ones(m, n);
thres = coeff_val*10/100;
coef_r = 1e-2;
coef_c = 1e-3;
r = 1 : 20;
step = 0.1;
for i = 1 : m
    sub_r = coef_r*(i - 1 + 1e-2) .^ 2;
    for j = 1 : n
        sub_c = coef_c*(j - 1) .^ 2;
        
        Dis_mat(i, j) = 1000* coeff_val * Dis_mat(i, j) + flag * 1/log(exp(1) + min(thres, sub_r) + 1e-3*sub_c)*2e2;
    end
end
mat_temp = mean(Dis_mat, 2);
abso_val = spline(r, mat_temp, 1:step:(max(r)));
end