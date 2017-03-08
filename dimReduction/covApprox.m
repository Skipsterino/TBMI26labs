function [Cov] = covApprox(data)
% Data has row number of features and col number of countries
N = size(data, 2);
numFeat = size(data,1);

Cov = zeros(numFeat);

for row = 1:numFeat
    for col = 1:numFeat
        meanRow = mean(data(row,:));
        meanCol = mean(data(col,:));
        
        for n = 1:N
            Cov(row,col) = Cov(row,col) +...
                (meanRow - data(row,n))*(meanCol - data(col,n))/N; 
        end
    end
end

