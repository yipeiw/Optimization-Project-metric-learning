function accuracy=evalKmeans(feature, labels)
opts = statset('Display','final');
classnum = length(unique(labels));
predict = kmeans(feature, classnum, 'Replicates',10,  'Options',opts);
accuracy = CalculateAccuracy(labels, predict);
end