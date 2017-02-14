function [ labelsOut ] = kNN(X, k, Xt, Lt)
%KNN Your implementation of the kNN algorithm
%   Inputs:
%               X  - Features to be classified
%               k  - Number of neighbors
%               Xt - Training features
%               LT - Correct labels of each feature vector [1 2 ...]'
%
%   Output:
%               LabelsOut = Vector with the classified labels
distVec=zeros(size(Xt,2),1);
dista=zeros(k,1);
index=zeros(k,1);
classVec=zeros(max(Lt),1);
Lt = Lt + 1;
%classes = unique(Lt);
%numClasses = length(classes);
labelsOut  = zeros(size(X,2),1);

for ii = 1:size(X,2)
    classVec=zeros(max(Lt),1);
    distVec=zeros(size(Xt,2),1);
    for jj = 1:size(Xt,2)
        for dim=1:size(X,1)
            distVec(jj)=distVec(jj)+(X(dim,ii)-Xt(dim,jj))^2;
        end
        distVec(jj)=sqrt(distVec(jj));
    end
  
    for kn=1:k
        
        [dista(kn),index(kn)] = min(distVec);
        distVec(index(kn))=Inf;
        classVec(Lt(index(kn))) = classVec(Lt(index(kn)))+1;
    end
    
    [numClassA, indexA]=max(classVec);
    
    foundClass=find(classVec == numClassA);
    
    if size(foundClass) > 1
        %2 eller fler klasser är samma antal, fixa
        distSumVec=zeros(max(Lt),1);
        for i=1:size(distVec,1)
            distSumVec(Lt(index(i)))=distSumVec(Lt(index(i)))+dista(i);
        end
        validDist=distSumVec(foundClass);
        [~,realIndex]=min(validDist);
        labelsOut(ii)=foundClass(realIndex);
    else
        labelsOut(ii)=indexA;
    end
        

end
 labelsOut = labelsOut - 1;



end

