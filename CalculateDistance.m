function distanceMats = CalculateDistance(feature, num)
distanceMats = zeros(num, num);
for i=1:num
    for j=i+1:num
        val = norm(feature(i, :)-feature(j, :))^2;
        distanceMats(i, j) = val;
        distanceMats(j, i) = val;
    end
end
end