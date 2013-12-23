clear all; clc;
addpath C:\Users\yipeiw\Documents\course-2013fall\optimization\project\Experiment\Xing_code

[feature, labels] = loadData('wine');
origin_accuracy=evalKmeans(feature, labels);

%ratio = 0.1; 
%ratio = 0.3;
%ratio = 0.5;
%ratio = 0.7;
ratio = 0.9;
keep=0.05; accuracy = []; iter=[];
C=0.01;
for i=1:20
    [S, D, chunk] = GenerateConstrain(labels, ratio);
    posNum = sum(S(:))
    negNum = sum(D(:))
    D_reduce = ReduceNeg(D, keep);
    %D_reduce = ReduceNeg_Dist(feature, D, keep);
    negNum=sum(D_reduce(:))

    [A, iternum] = Newton(feature, S, D_reduce, C);
    iter(i) = iternum;
    [V, dd]=eig(A);
    A_half = V*dd^(0.5);
    Tfeature=feature*A_half;
    accuracy(i)=evalKmeans(Tfeature, labels);
    clear Tfeature; clear S; clear D;
end

Ac = mean(accuracy)
Ac_std = std(accuracy)
cost_iter = mean(iter) 