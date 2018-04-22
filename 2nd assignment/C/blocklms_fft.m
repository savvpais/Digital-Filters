function [w, J] = blocklms_fft(u, d)

% Ensure that u and d are column vectors.
u = u(:);
d = d(:);

mu = 2.0e-04;
M = 2^10;
L = M;
w = zeros(2 * M, 1);
N = length(u);

% Iterate for k block index
kmax = floor(N / L) - 1;
J = zeros(1, kmax * L);
for k = 1:kmax
    % k-1-th block together with k-th block in a 2M length vector.
    newu = fft(u((k - 1) * M + 1:(k + 1) * M), 2 * M);
    newd = d(k * M + 1:(k + 1) * M);

    % For y keep only the last block, drop the first block.
    y = ifft(newu .* w);
    y = y(M + 1:2 * M, 1);
    e = newd - y;
    J((k - 1) * L + 1:k * L) = abs(e) .^ 2;
    % FFT transform e.
    e = fft([zeros(M, 1); e], 2 * M);
    phi = ifft(e .* conj(newu));
    phi = [phi(1:M); zeros(M, 1)];
    w = w + mu * fft(phi);
end