function [e, h] = errorf(d, y, x, threshold, haar)
h = zeros(length(y),1);
e = 0;

h = 2*(x(haar,:) >= threshold) - 1;
e = sum(d.*(h ~= y)'); 

end

