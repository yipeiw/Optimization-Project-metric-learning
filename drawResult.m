baseline=[0.8197, 0;
    0.7187, 0;
    0.8009, 0];

newton9 = [0.9179,0; 
    0.9076, 0.03; 
    0.816, 0.0097]; %iris, wine, protein
project9 = [0.8988, 0;
    0.7187, 0;
    0.7825, 0.0025];
SDP9=[0.9757, 0.0038;
    0.993, 0.0077;
    0.8849, 0.0074];
DEig9=[0.974,0;
    0.9975, 0.0036;
    0.9, 0.0103];

performance = zeros(3, 5);
Error = zeros(3, 5);
for nData=1:3
    performance(nData, 1)=baseline(nData, 1);  Error(nData, 1)=baseline(nData, 2);   
    performance(nData, 2)=newton9(nData, 1);  Error(nData, 2)=newton9(nData, 2);   
    performance(nData, 3)=project9(nData, 1); Error(nData, 3)=project9(nData, 2);
    performance(nData, 4)=SDP9(nData, 1);   Error(nData, 4)=SDP9(nData, 2);
    performance(nData, 5)=DEig9(nData, 1);  Error(nData, 5)=DEig9(nData, 2);
end

groupnames={'Iris';'Wine'; 'Protein'};
figure(1); barweb(performance, Error, 1, groupnames, 'Accuracy (ratio=0.9)');
legend('Baseline(Euclidean)','Newton','Iterative projected gradient', 'SDP', 'DEig', 'Location','BestOutside');
saveas(1, 'performance.eps', 'psc2');
saveas(1, 'performance.bmp', 'bmp');


iterOrign=[8, 90, 985, 11062];
iterSample=[5, 45, 488, 5592];

figure(2); hold on;
plot(iterOrign, 'b'); plot(iterSample, 'r');
legend('original', 'sampled');
title('Iteration Number of Deig on wine data');
ylabel('IterNum');
xlabel('tolerance');
set(gca,'XTickLabel',{'1e-6', '1e-8', '1e-10', '1e-12'});
saveas(2, 'sampleDeig.bmp', 'bmp');
saveas(2, 'sampleDeig.eps', 'psc2');

iterO=[17, 42, 21];
iterS=[14, 21, 13];
figure(3); hold on;
plot(iterO, 'b'); plot(iterS, 'r');
legend('original', 'sampled');
title('Iteration Number of SDP (tolerance=1e-6)');
ylabel('IterNum');
xlabel('dataset: iris, wine, protein');
saveas(3, 'sampleSDP.bmp', 'bmp');
saveas(3, 'sampleSDP.eps', 'psc2');

newton=[0, 0.8678, 0.9008, 0.899, 0.9184, 0.9076];
newton_error = [0, 0.049, 0.026, 0.037, 0.022, 0.03];

Deig=[0, 0.95, 0.9677, 0.9892, 0.9917, 0.9975];
Deig_error=[0,0.01, 0.025, 0.009, 0.0076, 0.0036];
figure(4); hold on;
r=[0 0.1 0.3 0.5 0.7 0.9];
errorbar(r, newton, newton_error, 'r');
errorbar(r, Deig, Deig_error,'b');
xlim([0 1]);
ylim([0 1]);
title('Accuracy');
xlabel('ratio of label');
legend('Xing','EDig', 'Location','Best');
saveas(4, 'labelratio.bmp', 'bmp');
saveas(4, 'labelratio.eps', 'psc2');

