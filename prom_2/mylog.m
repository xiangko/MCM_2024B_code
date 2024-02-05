function [lnp] =  mylog(p)
n = length(p);   % Length of vector
lnp = zeros(n,1);   % Initialize the final result
    for i = 1:n   % Start cycle
        if p(i) == 0   % If the i th element is 0
            lnp(i) = 0;  % Then the I-th result returned is also 0
        else
            lnp(i) = log(p(i));  
        end
    end
end