function D_reduce = ReduceNeg(D, keep)
[N M]=size(D);
D_reduce = zeros(N, N);
for i=1:N
    for j=i+1:N
        if rand(1)<=keep
            D_reduce(i, j)=D(i, j);
            D_reduce(j, i)=D(i, j);
        end
    end
end
end