function qfz=CacuQfz(Nextx,Nextz,Nowx,Nowz,endx,endy,endz,abscissa,HeightData)
%% This function is used to calculate the heuristic value for each point

%% Determine if the next point is reachable
if Nextz > HeightData(Nextx,abscissa)
    S=1;
else
    S=0;
end
%% Computed heuristic value
% distance
D=50/(sqrt(1+(Nowx-Nextx)^2+(Nowz-Nextz)^2)+sqrt((endx-Nextx)^2 ...
    +(endy-abscissa)^2+(endz-Nowz)^2));
% Calculated altitude
M=30/abs(Nextz+1);
% Computed heuristic value
qfz=S*M*D;
end