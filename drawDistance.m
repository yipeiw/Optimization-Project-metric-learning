name='protein';
[feature, labels] = loadData(name);
distanceMats = CalculateDistance(feature, length(labels));
figure(1); imagesc(distanceMats),colorbar;
saveas(1, strcat(name, '_origin.bmp'), 'bmp');
saveas(1, strcat(name, '_origin.eps'), 'psc2');

ratio = 0.9; keep=0.05; 
C=0.01;
[S, D, chunk] = GenerateConstrain(labels, ratio);  D_reduce = ReduceNeg(D, keep);

[A, iternum] = Newton(feature, S, D_reduce, C);
[V, dd]=eig(A);
A_half = V*dd^(0.5);
Tfeature=feature*A_half;

distanceMats = CalculateDistance(Tfeature, length(labels));
figure(2); imagesc(distanceMats),colorbar;
saveas(2, strcat(name, 'newton.bmp'), 'bmp');
saveas(2, strcat(name, '_newton.eps'), 'psc2');

[A, iternum] = opt_sphere(feature, S, D_reduce, 100);
[V, dd]=eig(A);
A_half = V*dd^(0.5);
Tfeature=feature*A_half;

figure(3); imagesc(distanceMats),colorbar;
saveas(3, strcat(name, '_IPG.bmp'), 'bmp');
saveas(3, strcat(name, '_IPG.eps'), 'psc2');

[A, iternum]=ML_eig(feature, S, D_reduce, 1e-6);
[V, dd]=eig(A);
A_half = V*dd^(0.5);
Tfeature=feature*A_half;

distanceMats = CalculateDistance(Tfeature, length(labels));
figure(4); imagesc(distanceMats),colorbar;
saveas(4, strcat(name, '_Deig.bmp'), 'bmp');
saveas(4, strcat(name, '_Deig.eps'), 'psc2');