function [ optK ] = findK(X, L)
%UNTITLED Summary of this function goes here
    %Finds the optimal k to use for a given data set X with correct
    %classifications L
%   Detailed explanation goes here
    %
    numData = size(X,2);
    
    curOptK=0;
    curOptAcc=0;
    fold = 10;
    
    for k=1:10
        accSum=0;
        for i=1:fold 
            Xp = X(:,1+(i-1)*numData/fold:i*numData/fold);
            Lp = L(1+(i-1)*numData/fold:i*numData/fold);
            if i == 1
                Xt = X(:,1+i*numData/fold:end);
                Lt = L(1+i*numData/fold:end);
            elseif i == 10
                Xt = X(:,1:end-numData/fold);
                Lt = L(1:end-numData/fold);
            else
                Xt=[X(:,1:(i-1)*numData/fold),X(:,1+i*numData/fold:end)];
                Lt=[L(1:(i-1)*numData/fold);L(1+i*numData/fold:end)];
            end
           
            classes=kNN(Xp,k,Xt,Lt);
            cM=calcConfusionMatrix(classes,Lp);
            acc=calcAccuracy(cM);
            accSum = accSum + acc;
            
        end
        accSum = accSum/fold;
        if accSum > curOptAcc
            curOptK = k;
            curOptAcc = accSum;
        end
        
    end
    optK = curOptK;
end

