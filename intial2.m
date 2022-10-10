function [indd, dex, ran, params] = intial2(type)
    if type == 1
        % 此时为参数最优选择，且解集的范围取值较大，若设为200，有可能解不在解集中
        params.prior_alpha_t = [0.5, 0.5];
        params.fusion_lamdba_t = 0.15;
        params.threshold = 1000;
    else
        params.prior_alpha_t = [0.5, 0.5];
        params.fusion_lamdba_t = 0.15;
        params.threshold = 200;
    end
    load('dex.mat')
    load('ran.mat')
    load('indd.mat')
end
