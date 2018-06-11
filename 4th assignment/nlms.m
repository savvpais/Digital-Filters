function [y, w, e] = nlms(u, d, M)

u = u(:);
d = d(:);
n = length(u);
mu = 10 ^ - 2;

w = zeros(M, 1);
y = zeros(size(u));
e = zeros(size(u));

for i = M + 1:n
    ubar = u(i:-1:i - M + 1);
    y(i) = w.' * ubar;
    e(i) = d(i) - y(i);
    lamda = mu / (norm(ubar) ^ 2 + 3);
    w = w + lamda * e(i) * ubar;
end

end
