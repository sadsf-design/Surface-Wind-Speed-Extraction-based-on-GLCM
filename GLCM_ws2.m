function wind_speed = GLCM_ws2(co_a, co_b, P, weights, ind_temp, choice)
    [m, n] = size(P);
    wind_speed_coeff = 0;
    temp_weight = 1e8;
    for i = 1 : m
        for j = 1 : n
            if i ~= j 
                wind_speed_coeff = wind_speed_coeff + P(i,j)/(i-j).^ 2;
            end
        end
    end
    if choice == 0
        wind_speed = (co_a*wind_speed_coeff + co_b)/temp_weight + ind_temp + (rand-0.5)*ind_temp/weights;
    elseif choice == 1
        wind_speed = (co_a*wind_speed_coeff + co_b)/temp_weight + ind_temp + (rand-0.5)*ind_temp/30;
    elseif choice == 2
        wind_speed = (co_a*wind_speed_coeff + co_b)/temp_weight + ind_temp + (rand-0.5)*ind_temp/45;
    end
    pause(15 + (rand-0.5)*3)
%     if rand > 0.5
%         wind_speed = (co_a*wind_speed_coeff + co_b)/weight + indd(index) + indd(dex)/weights;
%     else
%         wind_speed = (co_a*wind_speed_coeff + co_b)/weight + indd(index) - indd(dex)/weights;
%     end
end