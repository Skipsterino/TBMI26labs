function [ cM ] = calcConfusionMatrix( Lclass, Ltrue )
%CALCCONFUSIONMATRIX Summary of this function goes here
%   Detailed explanation goes here

classes = unique([Ltrue;Lclass]);
numClasses = length(classes);
cM = zeros(numClasses);

if classes(1) == 0;
    classes=classes+1;
end

for i = classes.'
    for j = classes.'
        cM(i,j) = sum((Lclass == j).*(Ltrue == i));
    end
end



end

