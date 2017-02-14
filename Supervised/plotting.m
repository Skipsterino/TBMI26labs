close all;
figure(1);
subplot(311);

scatter(X1(1,(L1 == 1)),-X1(2,(L1 == 1)),'b','x')
hold on;
scatter(X1(1,(L1 == 2)),-X1(2,(L1 == 2)),'r','x')
hold on;
title('data set 1')
subplot(312);

scatter(X2(1,(L2 == 1)),-X2(2,(L2 == 1)),'b','x')
hold on;
scatter(X2(1,(L2 == 2)),-X2(2,(L2 == 2)),'r','x')
hold on;
title('data set 2')
subplot(313);

scatter(X3(1,(L3 == 1)),-X3(2,(L3 == 1)),'b','x')
hold on;
scatter(X3(1,(L3 == 2)),-X3(2,(L3 == 2)),'r','x')
hold on;
scatter(X3(1,(L3 == 3)),-X3(2,(L3 == 3)),'g','x')
hold on;
title('data set 3')


