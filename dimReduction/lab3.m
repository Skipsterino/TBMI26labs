load countrydata;

normData = normalizeData(countrydata);

Cov = covApprox(normData);
Corr = corrApprox(Cov);

%%
[eigVec, eigVal] = sorteig(Cov);
figure(2);
bar(eigVal);
primVec = eigVec(:,1:2); 
figure(3);
for i=1:size(normData,2)
    v = inv(primVec'*primVec)*primVec'*normData(:,i);
    if (countryclass(i) == 0)
        plot(v(1),v(2),'rx');
    elseif (countryclass(i) == 1)
        plot(v(1),v(2),'gx');
    elseif (countryclass(i) == 2)
        plot(v(1),v(2),'bx');
    end
    hold on;
end
v = inv(primVec'*primVec)*primVec'*normData(:,41);
plot(v(1),v(2),'kx');
hold on;

%%
figure(1);
subplot(121);
colormap gray;
imagesc(Cov);
axis image;
subplot(122)
imagesc(Corr);
axis image;

%%
close 4;
cutData = countrydata(:,countryclass ~= 1);
cutNormData = normalizeData(cutData);
cutCountryClass = countryclass(countryclass ~= 1);
mean0 = mean(cutNormData(:,cutCountryClass == 0),2);
mean2 = mean(cutNormData(:,cutCountryClass == 2),2);
CovCut = covApprox(cutNormData);

w = inv(CovCut)*(mean0 - mean2);
figure(4);
histogram(w'*cutNormData(:,cutCountryClass == 0),13,'FaceColor' ,'r');
hold on;
histogram(w'*cutNormData(:,cutCountryClass == 2),10,'FaceColor' ,'b');


