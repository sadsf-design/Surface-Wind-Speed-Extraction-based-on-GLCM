function imrech_inverse = invers_z_transformation(imrech, inputIm2)
iz_imrech = ifft(imrech);
[m, n] = size(inputIm2(:, :, 1));

a = inputIm2(:, :, 1);
b = inputIm2(:, :, 2);
c = inputIm2(:, :, 3);

q = floor(rand(1, floor(m/50))*10);

iz_imrech_part_a = iz_imrech(1:m, 1:n);
weight = 1/sum(abs(iz_imrech_part_a(:)));

u = round(linspace(1, m, length(q)).*rand(1, length(q)));
u(1) = 1;
u(u<1) = 1;
u(u>m) = m;
u(end) = m;
v = round(linspace(1, n, length(q)).*rand(1, length(q)));
v(1) = 1;
v(v<1) = 1;
v(v>n) = n;
v(end) = n;
iz2_imrech_a = a + uint8(my_sparse(u, v, q).*abs(iz_imrech_part_a)/weight);

implace_m = floor(m/30);
implace_n = floor(n/30);
iz_imrech_part_b = iz_imrech(implace_m:m+implace_m-1, implace_n:n+implace_n-1);
weight = 1/sum(abs(iz_imrech_part_b(:)));

u = round(linspace(1, m, length(q)).*rand(1, length(q)));
u(1) = 1;
u(u<1) = 1;
u(u>m) = m;
u(end) = m;
v = round(linspace(1, n, length(q)).*rand(1, length(q)));
v(1) = 1;
v(v<1) = 1;
v(v>n) = n;
v(end) = n;
iz2_imrech_b = b + uint8(my_sparse(u, v, q).*abs(iz_imrech_part_b)/weight);

implace_m = floor(m/10);
implace_n = floor(n/10);
iz_imrech_part_c = iz_imrech(implace_m:m+implace_m-1, implace_n:n+implace_n-1);
weight = 1/sum(abs(iz_imrech_part_c(:)));

u = round(linspace(1, m, length(q)).*rand(1, length(q)));
u(1) = 1;
u(u<1) = 1;
u(u>m) = m;
u(end) = m;
v = round(linspace(1, n, length(q)).*rand(1, length(q)));
v(1) = 1;
v(v<1) = 1;
v(v>n) = n;
v(end) = n;
iz2_imrech_c = c + uint8(my_sparse(u, v, q).*abs(iz_imrech_part_c)/weight);

for i = 1 : m
    for j = 1 : n
        if iz2_imrech_a(i, j) ~= 255 || iz2_imrech_b(i, j) ~= 255 || iz2_imrech_c(i, j) ~= 255
            iz2_imrech_a(i, j)=iz2_imrech_a(i, j); 
            iz2_imrech_b(i, j)=iz2_imrech_b(i, j)*1.2;
            iz2_imrech_c(i, j)=iz2_imrech_c(i, j)*1.5;
        end
    end
end
imrech_inverse = cat(3, iz2_imrech_a, iz2_imrech_b, iz2_imrech_c);
end