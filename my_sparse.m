function sq = my_sparse(u, v, q)
m = max(u);
n = max(v);

sq = zeros(m, n);
for i = 1 : length(m)
    sq(u(i), v(i)) = q(i);
end