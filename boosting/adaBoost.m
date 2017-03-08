load faces, load nonfaces
faces = double(faces); nonfaces = double(nonfaces);
nbrHaarFeatures = 300;
nbrTrainExamples = 200;

haarFeatureMasks = GenerateHaarFeatureMasks(nbrHaarFeatures);

trainImages = cat(3,faces(:,:,1:nbrTrainExamples),nonfaces(:,:,1:nbrTrainExamples));

xTrain = ExtractHaarFeatures(trainImages,haarFeatureMasks);
yTrain = [ones(1,nbrTrainExamples), -ones(1,nbrTrainExamples)];

%%
close all;

Hsum = zeros(2*nbrTrainExamples, 1);


T = 20;
haar = nbrHaarFeatures;
M = length(yTrain);
d = ones(M,T)/M;

eOpt = ones(T,1)*Inf;
pOpt = ones(T,1);
thresholdOpt = zeros(T,1);
h = zeros(M,T);
alph = zeros(T,1);
haarOpt = zeros(T,1);

accs = zeros(T+1,1);

for t = 1:T
    for haf=1:haar
        inp = xTrain(haf,:);
        for i = inp
           [e, he] = errorf(d(:,t), yTrain, xTrain, i, haf);

           p = 1;
           if e > 0.5
                p = -1;
                e = 1 - e;
           end

           if e < eOpt(t)
              eOpt(t) = e;
              pOpt(t) = p;
              thresholdOpt(t) = i + 0.5;
              h(:,t) = he;
              haarOpt(t) = haf;
           end
        end
    end

    alph(t) = 0.5*log((1-eOpt(t))/eOpt(t));
    d(:,t+1) = d(:,t) .* exp(-alph(t)*pOpt(t)*yTrain'.*h(:,t));
    d(:,t+1) = d(:,t+1)./sum(d(:,t+1));


    Hsum = Hsum + pOpt(t)*alph(t)*h(:,t);
    HsumT = sign(Hsum);

    accs(t) = sum(HsumT == yTrain')/(2*nbrTrainExamples);
    
end

figure(1);
plot(accs(1:T), 'LineWidth', 1.5);

xlabel('Weak classifiers')
ylabel('Accuracy')
title('Boosting')
hold on;

%%
nbrTestSamp = 100;
testImages = cat(3,faces(:,:,nbrTrainExamples+1:nbrTrainExamples+nbrTestSamp),nonfaces(:,:,nbrTrainExamples+1:nbrTrainExamples+nbrTestSamp));

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

Hsum = zeros(2*nbrTestSamp, 1);


for i = 1:T
    hTest(:,i) = pOpt(i)*(2*(xTest(haarOpt(i),:) >= thresholdOpt(i)) - 1)';
    Hsum = Hsum + alph(i)*hTest(:,i);
end

Hsum = sign(Hsum);

acc = sum(Hsum == yTest')/(2*nbrTestSamp)
accs(T+1) = acc;

plot(T+1,accs(T+1), 'x', 'LineWidth', 1.5);
hold off;
