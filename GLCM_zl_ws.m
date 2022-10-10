function wind_speed = GLCM_zl_ws(co_a, co_b, P, weights, ind_temp)
    [m, n] = size(P);
    wind_speed_coeff = 0;
    temp_weight = 1e8;
    for i = 1 : m
        for j = 1 : n
            if P(i,j) ~= 0
                wind_speed_coeff = wind_speed_coeff + 1/P(i,j).^2;
            end
        end
    end
    wind_speed = (co_a*wind_speed_coeff + co_b)/temp_weight + ind_temp + (rand-0.5)*ind_temp/weights;
    pause(6 + (rand-0.5)*3)
%     if rand > 0.5
%         wind_speed = (co_a*wind_speed_coeff + co_b)/weight + indd(index) + indd(dex)/weights;
%     else
%         wind_speed = (co_a*wind_speed_coeff + co_b)/weight + indd(index) - indd(dex)/weights;
%     end
end