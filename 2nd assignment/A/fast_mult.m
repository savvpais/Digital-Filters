function y = fast_mult(a, b, w)

% Set a to be a column vector
a = a(:);
% Set b to be a row vector
b = b(:)';

% Do the multiplication
n=length(a);
c=[a; 0; fliplr(b(2:end)).'];
p=ifft(fft(c).*fft([w; zeros(n,1)]));
y=p(1:n);
