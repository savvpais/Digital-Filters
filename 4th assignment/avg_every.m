function [y, x] = avg_every(a, n)

x = 1:n:length(a) - n + 1;
y = arrayfun(@(i) mean(a(i:i + n - 1)), x); % the averaged vector

end
