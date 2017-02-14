function [e, h] = errorf(d, y, x, threshold, haar)
M = length(y);
h = zeros(M,1);
e = 0;

    h = 2*(x(haar,:) >= threshold) - 1;
    e = sum(d.*(h ~= y)'); 

%     for i = 1:M
%        if x(t,i) < threshold
%            h(i) = -1;
%        else
%            h(i) = 1;
%        end
%        if h(i) ~= y(i)
%           e = e + d(i); 
%        end
%        
%     end

end

