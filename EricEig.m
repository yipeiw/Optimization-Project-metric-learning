clear all; clc;
[feature, labels] = loadData('iris');
origin_accuracy=evalKmeans(feature, labels);

dim = length(feature(1, :));
addpath C:\Users\yipeiw\Documents\course-2013fall\optimization\project\Experiment\sedumi-master\sedumi-master

%ratio = 0.3; 
%ratio = 0.5; 
%ratio = 0.7; 
ratio = 0.9; %0.9553, 0.0039, 985

keep=0.01; accuracy = []; iter=[];
error = 1e-6;

for i=1:5
    [S, D] = GenerateConstrain(labels, ratio);
    posNum = sum(S(:))
    negNum = sum(D(:))
    D_reduce = ReduceNeg(D, keep);
    %D_reduce = ReduceNeg_Dist(feature, D, keep);
    negNum=sum(D_reduce(:))
    %[A0, A0_half] =RCA(feature,chunk);  %other initialization
    %E=eig(A0);
    %init=rand(dim);

    [A, iternum]=ML_eig(feature, S, D_reduce, error);
    
    iter(i) = iternum;
    [V, dd]=eig(A/norm(A));
    A_half = V*dd^(0.5);
    Tfeature=feature*A_half;
    accuracy(i)=evalKmeans(Tfeature, labels);
    clear Tfeature; clear S; clear D;
end

Ac = mean(accuracy)
Ac_std = std(accuracy)
cost_iter = mean(iter)