function [ind,path,pheromone]=searchpath(PopNumber,moveGrid,levelGrid,pheromone,d_show,startx,starty,startz,endx,endy,endz)
xcMax=2;   % Maximum lateral change of ants
zcMax=2;   % Maximum longitudinal change of ants
decr=0.5;  % Pheromone decay probability
%% Circular search path
for ii=1:PopNumber
    path(ii,1:2)=[startx,startz];  % Record path
    NowPoint=[startx,startz];      % Current coordinate point 
    count = 2;
    %% Calculate the point fitness value
    for abscissa=starty+1:endy-1
        % Calculate the fitness values corresponding to all data points
        kk=1;
        for i=-xcMax:xcMax
            for j = -zcMax:zcMax
                NextPoint(kk,:)=[NowPoint(1)+i,NowPoint(2)+j];
                if (NextPoint(kk,1)<moveGrid)&&(NextPoint(kk,1)>0)&&(NextPoint(kk,2)<levelGrid)&&(NextPoint(kk,2)>d_show(NextPoint(kk,1),abscissa))
                    qfz(kk)=CacuQfz(NextPoint(kk,1),NextPoint(kk,2),NowPoint(1),NowPoint(2),endx,endy,endz,abscissa,d_show);
                    qz(kk)=qfz(kk)*pheromone(NextPoint(kk,1),abscissa,NextPoint(kk,2));
                    kk=kk+1;
                else
                    qz(kk)=0;
                    kk=kk+1;
                end
            end      
        end
        % Select the next point
        sumq=qz./sum(qz);
        pick=rand;
        
        while pick==0
            pick=rand;
        end
        mp = pick;
        for i=1:25
            pick=pick-sumq(i);
            if pick<=0
                index=i;
                ind(ii) = index;
                break;
            end
        end
        try
            oldpoint=NextPoint(index,:);
        catch
            for mc = 1:25
                if NextPoint(mc) ~= 0
                    index = mc;
                    break;
                end
            end
                    
            oldpoint=NextPoint(index,:);
        end
%         Renewal pheromone
        if oldpoint(2)<1
            oldpoint(2) = 1;
        end
        if oldpoint(1)<1
            oldpoint(1) = 1;
        end
        if oldpoint(1)>moveGrid
            oldpoint(1) = moveGrid;
        end
        pheromone(oldpoint(1),abscissa,oldpoint(2))=decr*pheromone(oldpoint(1),abscissa,oldpoint(2));
        % Path saving
        path(ii,count*2-1:count*2)=[oldpoint(1),oldpoint(2)];
        count = count + 1;
        NowPoint=oldpoint; 
    end
    path(ii,(endy-starty)*2+1:(endy-starty)*2+2)=[endx,endz];
end