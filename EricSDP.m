clear all; clc;
[feature, labels] = loadData('wine');
origin_accuracy=evalKmeans(feature, labels);

dim = length(feature(1, :));
addpath C:\Users\yipeiw\Documents\course-2013fall\optimization\project\Experiment\sedumi-master\sedumi-master

%ratio = 0.1; 
%ratio = 0.3;
%ratio = 0.5;
%ratio = 0.7;
ratio = 0.9;
keep=0.05; accuracy = []; iter=[];

for i=1:1
    [S, D] = GenerateConstrain(labels, ratio);
    posNum = sum(S(:))
    negNum = sum(D(:))
    D_reduce = ReduceNeg(D, keep);
    negNum=sum(D_reduce(:))

    [At, b, c, K] = Transform2SDP(feature, S, D_reduce);
    [x,y,info]=sedumi(At,b,c,K);
    [A, t, slack] = ExtractParam(mat(x), dim);
    
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