function [w, J] = blocklms_nested(u, d)

% Ensure that u and d are column vectors.
u = u(:);
d = d(:);

mu = 2.0e-04;
M = 2^10;
L = M;
w = zeros(M, 1);
N = length(u);

% Iterate for k block index
kmax = floor(N / L) - 1;
J = zeros(1, kmax * L);
for k = 1:kmax
    phi = zeros(M, 1);
    for i = 0:L - 1
        idx = k * L + i:-1:k * L + i - M + 1;
        newu = u(idx);
        newd = d(idx(1));
        y = w'*newu;
        newe = newd - y;
        J((k - 1) * L + i + 1) = newe .^ 2;
        phi = phi + mu * newe * newu;
    end
    w = w + phi;
end