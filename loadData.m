function [feature, labels] = loadData(name)
if strcmp(name, 'wine')
    data=csvread('data\wine.data');
    labels = data(:, 1);
    feature = data(:, 2:end);
end

if strcmp(name, 'iris')
    load fisheriris
    classname=unique(species);
    labels = zeros(length(species), 1);
    for i=1:length(classname)
        classIdx = find(strcmp(species, classname(i)));
        labels(classIdx)=i;
    end
    feature=meas;
end

if strcmp(name, 'protein')
    load('data\proteinData');
    feature = data;
end

end