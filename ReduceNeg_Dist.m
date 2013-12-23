function D_reduce = ReduceNeg_Dist(data, D, keep)
[N M]=size(D);
dist = zeros(N, N);
D_reduce = zeros(N, N);
total = sum(D(:))*keep;

for i=1:N
    for j=i+1:N
        if D(i,j) == 1    
            d_ij = data(i,:) - data(j,:);            
            dist(i, j) = d_ij*d_ij';
        end 
    end
end

[val, idx] = sort(dist(:));
for i=10:total+10
    [row, col] = ind2sub(size(dist), idx(i));
    D_reduce(row, col)=1;
end
end