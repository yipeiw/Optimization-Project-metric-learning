function accuracy = CalculateAccuracy(labels, predicts)
samples = length(labels);
if samples~=length(predicts)
    tag='error: label and predict unequal'
end

correct = zeros(samples, samples);
for i=1:samples
    for j=i+1:samples
        if (labels(i)==labels(j)) && (predicts(i)==predicts(j))
            correct(i, j)=1;
        end
        if (labels(i)~=labels(j)) && (predicts(i)~=predicts(j))
            correct(i, j)=1;
        end
    end
end

accuracy = sum(correct(:))/0.5/samples/(samples-1);
end