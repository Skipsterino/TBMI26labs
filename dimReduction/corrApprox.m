function [Corr] = corrApprox(Cov)
len = size(Cov,1);
Corr = zeros(len);

for row = 1:len
    for col = 1:len
        Corr(row,col) = Cov(row,col)/sqrt(Cov(row,row)*Cov(col,col));
    end
end

end

