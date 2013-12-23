function [A, t, slack] = ExtractParam(X, dim)
    [m m] = size(X);
    A=X(1:dim, 1:dim);
    t=X(dim+1, dim+1);
    
    slack = [];
    for i=dim+2:m
        slack = [slack, X(i,i)];
    end
end