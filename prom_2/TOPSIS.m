 clc
clear
X=xlsread('statistical table.xlsx');
save('X.mat',"X");
load X.mat;
[n,m] = size(X);
disp(['There are ' num2str(n) ' evaluation objects. There are ' num2str(m) ' evaluation indicators'])
judge=input(['Whether the ' num2str(m) ' indicator needs to be forward processed, please enter 1 if yes, please enter 0 if no: '])
%We should enter 1
if judge==1
    Pos=input('Please enter the columns that need to be forward processed such as 1,2, and 3 columns that need to be processed [1,2,3] :');
    %We should enter [2,3,4,5]
    disp('Please enter what indicator type these columns are (1: very small 2: intermediate 3: interval)')
    Type=input('For example, columns 1, 2 and 3 are very small interval types, and the middle type is [1,3,2] :');
    %We should enter [1,1,1,1]
    for i=1:size(Pos,2)
        X(:,Pos(i))=Positivization(X(:,Pos(i)),Type(i),Pos(i));
    end
    disp('The forward matrix is X=');
    disp(X);
end
%standardization
Z = X ./ repmat(sum(X.*X) .^ 0.5, n, 1);
disp('normalized matrix Z =')
disp(Z)
 

disp('Please enter whether you want to increase the weight vector, you need to enter 1, you do not need to enter 0');
%We should enter 1
Judge = input('Please enter whether you want to increase the weight: ');
if Judge == 1
    if sum(sum(Z<0))>0
        disp('There are negative numbers in the normalized matrix being re-normalized.')
        for j=1:m
            minn=min(Z(:,j));
            maxx=max(Z(:,j));
            for i=1:n
                Z(i,j)=(Z(i,j)-minn)/(maxx-minn)
            end
        end
        disp('normalized completion matrix Z= ');
        disp(Z);
    end
    W = Entropy_Method(Z);
    disp('The weights determined by entropy weight method are: ');
    disp(W);        
else
    W = ones(1,m) ./ m ; %If no weight is required, the default weight is the same, that is, 1/m
end
 
 
D_P = sum([W .* (Z - repmat(max(Z),n,1)) .^ 2 ],2) .^ 0.5;%Optimal distance
D_N = sum([W .* (Z - repmat(min(Z),n,1)) .^ 2 ],2) .^ 0.5;%Worst distance
S = D_N ./ (D_P+D_N);%Relative proximity（It can be used to score points）   
disp('The final score is: ')
stand_S = S / sum(S)%Score normalization The final score of each scheme is added to 1
[sorted_S,index] = sort(stand_S ,'descend');
disp('The schemes ranked from highest to lowest score are:  ');
disp(index);%Scheme ranking
 
 