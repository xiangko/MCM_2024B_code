%Calculated weight
function [W] = Entropy_Method(Z)
    [n,m]=size(Z);
    d=zeros(1,m);
    for i=1:m
        x = Z(:,i);
        p = x./sum(x);%Probability matrix
        D = -sum(p .* mylog(p)) / mylog(n);%Information entropy
        d(i)=1-D;%Information utility value
    end
    W=d./sum(d)%Entropy weight
    W(1)=W(1)*1;
    W=W./sum(W)%Modify the weights based on geographic information
end