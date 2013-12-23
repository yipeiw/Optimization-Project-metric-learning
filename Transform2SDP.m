function [At, b, c, K] = Transform2SDP(data, S, D)
[N, dim] = size(data);
negNum = sum(D(:));

b=[zeros(negNum,1); 1];
total = dim+negNum+2;
c=vec(sparse(dim+1, dim+1, 1, total, total));
At=sparse([],[],[], total^2, negNum+1, (dim^2+2)*(negNum+1));

postotal = zeros(dim,dim);
k=1;
for i = 1:N
    for j= i+1:N
        if D(i,j) == 1    
            d_ij = data(i,:) - data(j,:);
            E_k=sparse([1, 1+k],[1, 1+k],[-1, -1], negNum+2, negNum+2);
            At(:, k) = vec(sparse(blkdiag(d_ij'*d_ij, E_k)));
            k = k+1;
        end  
        
        if S(i, j) == 1
            d_ij = data(i,:) - data(j,:);
            postotal = postotal +  d_ij'*d_ij;
        end
    end
end

E=sparse(negNum+2,negNum+2,1, negNum+2,negNum+2);
At(:, negNum+1) = vec(sparse(blkdiag(postotal,E)));
K.s=[total];
end