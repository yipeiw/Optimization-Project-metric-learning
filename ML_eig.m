function [A, iternum]=ML_eig(data, S, D, tol, M0)
[Xs_half_inv, Xd, dim] = CalculateParam(data, S, D);

if ~exist('M0','var')
    M0=diag(1/dim*ones(dim, 1));  
end

M=M0;
u=1e-5;

fu_val = fu(M, Xd, u);

iternum = 1;
while 1
    alpha = 0.9/iternum;
    g_fu = grad_fu(M, Xd, u);
    vmax = eigs(g_fu, 1, 'lm');
    Zt=vmax*vmax';
    M_update=(1-alpha)*M + alpha*Zt;
    fu_val_update = fu(M_update, Xd, u);
    if abs(fu_val_update-fu_val) < tol
        break
    end
    M = M_update;
    fu_val = fu_val_update;
    
    iternum = iternum + 1;
end
A = Xs_half_inv*M*Xs_half_inv;
end

function [Xs_half_inv, Xd, dim] = CalculateParam(data, S, D)
[N, dim] = size(data);
Xs=zeros(dim, dim);
for i = 1:N
    for j= i+1:N       
        if S(i, j) == 1
            d_ij = data(i,:) - data(j,:);
            Xs = Xs +  d_ij'*d_ij;
        end
    end
end
Xs_half_inv = Xs^(-0.5);

Xd = [];
for i = 1:N
    for j= i+1:N
        if D(i,j) == 1    
            d_ij = data(i,:) - data(j,:);            
            Xd = [Xd; vec(Xs_half_inv*(d_ij'*d_ij)*Xs_half_inv)'];
        end  
    end
end
end

function g=grad_fu(M, X, u)
[num, dim] = size(X);
sum_numerator=zeros(1, dim);
sum_denominator=0;
for i=1:num
    val = X(i, :)*vec(M);
    sum_numerator = sum_numerator + exp(-val/u)*X(i,:);
    sum_denominator = sum_denominator + exp(-val/u);
end

g=mat(sum_numerator./sum_denominator);
end

function f=fu(M, X, u)
[num, dim] = size(X);
sumtotal=0;
for i=1:num
    val = X(i, :)*vec(M);
    sumtotal = sumtotal + exp(-val/u);
end
f=-u*log(sumtotal);
end

