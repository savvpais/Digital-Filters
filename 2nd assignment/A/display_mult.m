clear; 
close all;

% Vector dimensions for multiplication results diplay
n_values = [10^3 2*10^3 3*10^3 4*10^3 5*10^3 6*10^3 7*10^3 8*10^3];
m_values = [10^2 2*10^2 3*10^2 4*10^2 5*10^2 6*10^2 7*10^2 8*10^2];

for i = 1:length(n_values)
    % Create random inputs
    u = randn(n_values(i), 1);
    w = randn(m_values(i), 1);
    
    fprintf(1,'For n = %d\n\n',n_values(i));
    tic;
    yf = fast_mult(u(m_values(i):n_values(i)), u(m_values(i):-1:1), w);
    t = toc;
    fprintf(1,'Time for fast multiplication: %f\n', t);
    
    tic;
    y = toeplitz(u(m_values(i):n_values(i)), u(m_values(i):-1:1)) * w;
    t = toc;
    fprintf(1,'Time for standard multiplication: %f\n', t);
    fprintf(1,'Relative error between the two results: %e\n\n', norm(yf-y)/norm(y));
    end
