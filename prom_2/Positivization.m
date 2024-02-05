% Positivization The three input variables are the column vector currently 
% being processed which column is currently being processed by the indicator type of the column
%The output variable is a positive column vector
function [posit_x]=Positivization(x,type,i)
    if type==1 %Minimal size
        posit_x=max(x)-x;
        %posit_x=1./x This can also be done if the column data is all greater than 0
    elseif type==2%Intermediate type
        best=input('Please enter the best value:  ');
        M=max(abs(x-best));
        posit_x=1-abs(x-best)/M;
    elseif type==3%Interval type
        a=input('Enter the lower limit of the interval:  ');
        b=input('Please enter upper limit of range:  ');
        N=max(a-min(x),max(x)-b);
        posit_x = zeros(size(x,1),1);
        for i=1:size(x,1)
            if x(i)<a
                posit_x(i)=1-(a-x(i))/N;
            elseif x(i)>b
                posit_x(i)=1-(x(i)-b)/N;
            else
                posit_x(i)=1;
            end
        end
    else 
        disp('Please enter the correct indicator type')
    end
end