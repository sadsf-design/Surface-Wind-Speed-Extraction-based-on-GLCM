function wind_speed = qxrd_bz_bb_beta(type, index, P)
% type = 1;
[dex, ran, params] = intial2(type);
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
wind_speed = dex(index) + abso_val(end)/1e8;
end