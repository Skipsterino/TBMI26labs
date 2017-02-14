% Load saved figures
c=hgload('data1testk=2.fig');
k=hgload('data1traink=2.fig');
% Prepare subplots
figure
h(1)=subplot(121);
h(2)=subplot(122);
% Paste figures on the subplots
copyobj(allchild(get(c,'CurrentAxes')),h(1));
copyobj(allchild(get(k,'CurrentAxes')),h(2));
% Add legends
%l(1)=legend(h(1),'LegendForFirstFigure')
%l(2)=legend(h(2),'LegendForSecondFigure')