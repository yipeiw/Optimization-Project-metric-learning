function [S, D, chunk] = GenerateConstrain(labels, ratio)
    classname=unique(labels);
    samples = length(labels);
    S = zeros(samples, samples);
    D = ones(samples, samples);
    chunk = [];
    for i=1:length(classname)
        filter = find(labels==classname(i));
        classNum = length(filter);
        randlist = randperm(classNum);
        similar = filter(randlist(1:ceil(ratio*classNum)));
        S(similar, similar) = 1;
        D(similar, similar) = 0;
        chunk = [chunk, i*ones(1, length(similar))];
    end
end