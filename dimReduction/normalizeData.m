function [normData] = normalizeData(data)
% Data has row number of features and col number of countries

numFeat = size(data,1);
normData = zeros(numFeat, size(data,2));

for i = 1:numFeat
    normData(i,:) = data(i,:)/max(data(i,:));
end

