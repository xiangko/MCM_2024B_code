%% 
% This function is used to demonstrate a 3D path planning algorithm 
% based on ant colony algorithm

%% Clear environment variable
clc
clear

%% Data initialization

% Load data
load d_show

min_value = min(min(d_show));
d_show = d_show - min_value;
d_show = d_show/40;
d_show = double(d_show);

% meshing
moveGrid=245;
PortGrid=468;
levelGrid = 250;

% Define starting and ending grid points
startx=150;starty=200;startz=d_show(startx,starty)+60;
endx=214;endy=309;endz = d_show(endx,endy)+50;
dyy = abs(starty - endy);
dzz = startz - endz;
dxx = abs(startx - endx);
disp([dxx,dyy,dzz]);


% Set algorithm parameters
PopNumber=100;         % Population number
BestFitness=[];        % Defines a list of the best individuals to store

% Initial pheromone
pheromone=ones(245,468,250);

%% Initial search path
[ind,path,pheromone]=searchpath(PopNumber,moveGrid,levelGrid,pheromone, ...
    d_show,startx,starty,startz,endx,endy,endz); 
fitness=CacuFit(path);                          % Fitness calculation
[bestfitness,bestindex]=min(fitness);           % Optimum fitness
bestpath=path(bestindex,:);                     % Optimum path
BestFitness=[BestFitness;bestfitness];          % Fitness value records
 
%% Pheromone renewal
rou=0.2;
cfit=100/bestfitness;
for i=1:endy-starty
    pheromone(bestpath(i*2-1),i,bestpath(i*2))= ...
        (1-rou)*pheromone(bestpath(i*2-1),i,bestpath(i*2))+rou*cfit;
end
    
%% Loop to find the optimal path
for kk=1:500
     
    %% Path search
    [ind,path,pheromone]=searchpath(PopNumber,moveGrid,levelGrid,pheromone, ...
    d_show,startx,starty,startz,endx,endy,endz); 
    
    %% Fitness value is updated
    fitness=CacuFit(path);                               
    [newbestfitness,newbestindex]=min(fitness);     
    if newbestfitness<bestfitness
        bestfitness=newbestfitness;
        bestpath=path(newbestindex,:);
    end 
    BestFitness=[BestFitness;bestfitness];
    
    %% Renewal pheromone
    cfit=100/bestfitness;
    for i=1:endy-starty
        pheromone(bestpath(i*2-1),i,bestpath(i*2))=(1-rou)* ...
            pheromone(bestpath(i*2-1),i,bestpath(i*2))+rou*cfit;
    end
 
end

%% Optimum path
for i=1:endy-starty+1
    a(i,1)=bestpath(i*2-1);
    a(i,2)=bestpath(i*2);
end
figure(1)
hold on
meshz(d_show)

k=starty:endy;
plot3(k(1)',a(1,1)',a(1,2)','--o','LineWidth',2,...
                       'MarkerEdgeColor','g',...
                       'MarkerFaceColor','g',...
                       'MarkerSize',10)
plot3(k(end)',a(end,1)',a(end,2)','--o','LineWidth',2,...
                       'MarkerEdgeColor','g',...
                       'MarkerFaceColor','g',...
                       'MarkerSize',10)
text(k(1)',a(1,1)',a(1,2)','S');
text(k(end)',a(end,1)',a(end,2)','T');
xlabel('xkm','fontsize',12);
ylabel('ykm','fontsize',12);
zlabel('m','fontsize',12);
title('Three-dimensional path planning space','fontsize',12)
set(gcf, 'Renderer', 'ZBuffer')

plot3(k',a(:,1)',a(:,2)','--o')
hold off
% Fitness change
figure(2)
plot(BestFitness)
title('Trends of the best individual fitness')
xlabel('Number of iterations')
ylabel('Fitness value')
