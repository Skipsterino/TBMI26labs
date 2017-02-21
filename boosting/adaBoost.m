load faces, load nonfaces
faces = double(faces); nonfaces = double(nonfaces);
nbrHaarFeatures = 200;
nbrTrainExamples = 150;

haarFeatureMasks = GenerateHaarFeatureMasks(nbrHaarFeatures);

trainImages = cat(3,faces(:,:,1:nbrTrainExamples),nonfaces(:,:,1:nbrTrainExamples));

xTrain = ExtractHaarFeatures(trainImages,haarFeatureMasks);
yTrain = [ones(1,nbrTrainExamples), -ones(1,nbrTrainExamples)];

%%
close all;
figure(1);
for T = 5:5:100

haar = nbrHaarFeatures;
M = length(yTrain);
d = ones(M,T)/M;

eOpt = ones(T,1)*Inf;
pOpt = ones(T,1);
thresholdOpt = zeros(T,1);
h = zeros(M,T);
alph = zeros(T,1);
haarOpt = zeros(T,1);

for t = 1:T
    for haf=1:haar
        inp = xTrain(haf,:);
        for i = inp;
           [e, he] = errorf(d(:,t), yTrain, xTrain, i, haar);

           p = 1;
           if e > 0.5
                p = -1;
                e = 1 - e;
           end

           if e < eOpt(t)
              eOpt(t) = e;
              pOpt(t) = p;
              thresholdOpt(t) = i;
              h(:,t) = he;
              haarOpt(t) = haf;
           end
        end
    end

    alph(t) = 0.5*log((1-eOpt(t))/eOpt(t));
    d(pOpt(t)*h(:,t)==yTrain',t+1) = d(pOpt(t)*h(:,t)==yTrain',t).*exp(-alph(t));
    d(pOpt(t)*h(:,t)~=yTrain',t+1) = d(pOpt(t)*h(:,t)~=yTrain',t).*exp(alph(t));
    %d(:,t+1) = d(:,t) .* exp(-alph(t)*pOpt(t)*yTrain'.*h(:,t));
    d(:,t+1) = d(:,t+1)./sum(d(:,t+1));

end

Hsum = zeros(2*nbrTrainExamples, 1);

for i = 1:T
    Hsum = Hsum + pOpt(i)*alph(i)*h(:,i);
end

Hsum = sign(Hsum);

acc = sum(Hsum == yTrain')/(2*nbrTrainExamples)

plot(T, acc, '-o' , 'LineWidth', 1.5);
xlabel('Weak classifiers')
ylabel('Accuracy')
hold on;
drawnow;
end



%%
nbrTestSamp = 100;
testImages = cat(3,faces(:,:,1:nbrTestSamp),nonfaces(:,:,1:nbrTestSamp));
% 
% figure(1)
% colormap gray
% for k=1:25
% subplot(5,5,k), imagesc(testImages(:,:,k)), axis image, axis off
% end
% figure(2)
% colormap gray
% for k=101:125
% subplot(5,5,k-100), imagesc(testImages(:,:,k)), axis image, axis off
% end

xTest = ExtractHaarFeatures(testImages,haarFeatureMasks);
yTest = [ones(1,nbrTestSamp), -ones(1,nbrTestSamp)];

hTest = zeros(2*nbrTestSamp, T);
Hsum = zeros(2*nbrTestSamp, 1);

for i = 1:T
    hTest(:,i) = pOpt(i)*(2*(xTest(haarOpt(i),:) > thresholdOpt(i)) - 1)';
    Hsum = Hsum + alph(i)*hTest(:,i);
end

Hsum = sign(Hsum);

acc = sum(Hsum == yTest')/(2*nbrTestSamp) 


