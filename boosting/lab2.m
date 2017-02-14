% Load face and non-face data and plot a few examples
load faces, load nonfaces
faces = double(faces); nonfaces = double(nonfaces);
figure(1)
colormap gray
for k=1:25
subplot(5,5,k), imagesc(faces(:,:,10*k)), axis image, axis off
end
figure(2)
colormap gray
for k=1:25
subplot(5,5,k), imagesc(nonfaces(:,:,10*k)), axis image, axis off
end
% Generate Haar feature masks
nbrHaarFeatures = 100;
haarFeatureMasks = GenerateHaarFeatureMasks(nbrHaarFeatures);
figure(3)
colormap gray
for k = 1:25
subplot(5,5,k),imagesc(haarFeatureMasks(:,:,k),[-1 2])
axis image,axis off
end
% Create a training data set with a number of training data examples
% from each class. Non-faces = class label y=-1, faces = class label y=1
nbrTrainExamples = 100;
trainImages = cat(3,faces(:,:,1:nbrTrainExamples),nonfaces(:,:,1:nbrTrainExamples));
xTrain = ExtractHaarFeatures(trainImages,haarFeatureMasks);
yTrain = [ones(1,nbrTrainExamples), -ones(1,nbrTrainExamples)];

H = adaBoost(xTrain,yTrain, nbrHaarFeatures);

%% Testing testing 1 2 3

