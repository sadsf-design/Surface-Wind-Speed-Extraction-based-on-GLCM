clear
clc

type = 1;
[dex, ind, indd, params] = intial1(type);
lamdba_t = params.fusion_lamdba_t;
thres = params.threshold;
alpha_prior_t = params.prior_alpha_t;
abso_vals = cell(1, length(dex));
ran = rand(length(indd), 1);
aa = [];
% figure
% hold on

for i = 1 : length(dex)
    quad_options = optimoptions('quadprog','Display','off', 'OptimalityTolerance', 1e-4, 'StepTolerance', 1e-4, 'ConstraintTolerance', 1e-2);

    A =  eye(4)+rand(4);
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

    [soln, f_val] = quadprog(H, f, A, b, Aeq, beq, lb, ub, [], quad_options);

    coeff_val = dex(i);
    P = zeros(20, 360);
    if ran(i) > 0.5
        abso_val = abso_eff(coeff_val, P, 1);
    else
        abso_val = abso_eff(coeff_val, P, -1);
    end
    
    abso_vals{i} = abso_val;
    aa = [aa, abso_val(end)];
%     plot(1:0.1:20,(coeff_val+abso_vals{i}/1e3)*10)
end
corrcoef(dex+aa'/1e6, indd)
raw_x = dex+aa'/1e6;
[y, in] = unique(indd);
x = raw_x(in);

%% 稳态数据
wss = [2.2, 8.8, 12.4, 15.6, 19.2];
val = zeros(1, length(wss));
for i = 1 : length(wss)
    in = find(indd == wss(i), 1);
    
    val(i) = dex(in);
end
val = val;
rate = 0.05;
up_rate = 1e-2;
ran = [-1,-1,-1,1,1];
in2 = [1,9,12,15];
vals = val'.*ones(5, 200);
valss = cell(1, 5);
val_temp = zeros(1, 4);
figure
hold on
for i = 1 : length(ran)
    val_temp = val(i) * [(1 + ran(i)*rate), (1 + ran(i)*up_rate*rand), (1 - ran(i)*up_rate*rand), 1];

    real_val = spline(in2, val_temp, min(in2):max(in2));

    valss{i} = [real_val, vals(i, :)];
    plot(20/215:20/215:20, valss{i})
end