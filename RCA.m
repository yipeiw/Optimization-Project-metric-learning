
% RCA function. 

%Input :

% data - The data points as an N*D matrix, where N is the number of data points,
%              D the dimension of the data. Each data point is a row in the matrix.

% chunks - a vector of size N*1 describing the chunklets :                       
%               -1 in the i'th place says that point i doesn't belong to any chunklet
%               integer j in place i says that point i belongs to chunklet j.
%               The chunklets indexes should be 1:number_of chunklets

% useD  - optional. When not given, RCA is done in the original dimension
%               and B is full rank. When useD is given RCA is preceded by
%               constraints based LDA which reduces the dimension to useD. 
%               B in this case is of rank useD.


% Output :

% B - the RCA suggested Mahalanobis matrix.
% RCA - the RCA suggested transformation of the data
%           Its dimensions are (original data dimension)*(useD)
% newData - the data after the RCA transformation (A).

% for every two original data points x1,x2 with new images (in newData) y1,y2:
%  (x2-x1)'*B*(x2-x1) = || (x2-x1)*A ||^2 = || y2-y1||^2 

function [ B, RCA, newData ] =RCA(data,chunks,useD)

[ n,d ] = size(data);

if ~exist('useD','var')
    useD=d;
end

% subtract the mean
TM=mean(data);
data=data-ones(n,1)*TM;

% compute chunklet means and center data
S= max(chunks);
Cdata=[];
AllInds=[];
for i=1:S
    inds=find(chunks==i);
    M(i,:)=mean(data(inds,:));
    Cdata(end+1:end+length(inds),:)=data(inds,:)-ones(length(inds),1)*M(i,:);
    AllInds=[ AllInds ,inds ];
end

% Compute inner covariance matrix.
InnerCov=cov(Cdata,1);

% Optional  cFLD : find optimal projection:  min | A S_w A^t | / | A S_t A^t |  
if useD<d     
    TotalCov=cov(data(AllInds,:));    % compute total covariance using only chunkleted points.
    % TotalCov= cov(data);  % compute total covariance using all the data. More accurate, but may lead to PSD problems.
    [ V D ]=eig(inv(TotalCov)*InnerCov);
    [ OD inds ]=sort(diag(D));
    V=V(:,inds);    %reorder the vectors in descending order 
    A=V(:,1:useD);       % A is the cFLD transformation. Acts on row data by multiplication from the right.
    InnerCov = A'*InnerCov*A;
else
    A=eye(d);
end

 %RCA: whiten the data w.r.t the inner covariance matrix
RCA=A*(InnerCov)^(-0.5);    % operate from the right on row vectors

newData = ( data+ones(n,1)*TM) * RCA;      % The total mean subtracted is re-added before transformation. This operation is not required for distance computations, as it only adds a constant to all points.
B=RCA *RCA' ;

