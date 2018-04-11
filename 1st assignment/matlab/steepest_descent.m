function [w_tot, w] = steepest_descent (R, p, mu, e, max_rep)

%Set max repeats and maximum error, in case  the corresponding function
%inputs are missing
if ~exist('max_rep', 'var')
    max_rep = 1000;
end

if ~exist('e', 'var')
    e = 0.001;
end

%Initialize w_tot. W_tot is the history of w in each step of the algorithm
w = [-1; -1];
w_tot = zeros(max_rep, length(R));
w_tot(1,:) = w;

for i = 2:max_rep
    w = w + mu * (p - R * w);
    w_tot(i, :) = w;
    %Stop if the current step is really small
    if norm(w_tot(i) - w_tot(i - 1)) < e
        %Shrink the size of w_tot to match the number of steps done
        w_tot = w_tot(1:i, :);
        break;
    end
end

end