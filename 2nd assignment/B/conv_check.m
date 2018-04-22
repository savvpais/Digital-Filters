function tf = conv_check(n, m)

clear;

if ~exist('n', 'var')
    n = 1000;
end
if ~exist('m', 'var')
    m = 1000;
end

% Initialize random vectors
x = randn(1,n);
y = randn(1,m);

% Compute convolution with conv()
A = conv(x,y);

% Compute convolution with toeplitz array

[M,N] = size(A);
[p1,p2] = size(x);
[d1,d2] = size(y);

% Construct Toeplitz array
k = [y zeros(1,N-d2)];
r = [k(1) zeros(1,n-1)];
Y = toeplitz(k,r);

B = Y * x';
B = B';


% Compute convolution with fft
x1 = [x zeros(1,N-p2)];
y1 = [y zeros(1,N-d2)];

f1 = fft(x1);
f2 = fft(y1);

D = real(ifft(f1.* f2));

tf = 1;
if norm(A-B)/norm(A) > 1.000e-10
  tf = 0;
elseif norm(A-D)/norm(A) > 1.000e-10
  tf = 0;
end