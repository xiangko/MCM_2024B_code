function fitness=CacuFit(path)
%% This function is used to calculate individual fitness values

[n,m]=size(path);
for i=1:n
    fitness(i)=0;
    for j=2:m/2
        % The fitness value is length plus height
        fitness(i)=fitness(i)+sqrt(1+(path(i,j*2-1)-path(i,(j-1)*2-1))^2 ...
            +(path(i,j*2)-path(i,(j-1)*2))^2);
    end
end