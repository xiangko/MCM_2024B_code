%% prom_1
% Because the first question is the differential equation solved by matlab ode45, 
% which will consume a long time, in order to shorten the code running time,
% we store the mobile data in move_data.mat

%% Clear data
clc
clear

%% Load data
load move_data.mat

t = move_data(:,1);
x = move_data(:,2);
y = move_data(:,3);
z = move_data(:,4);

%% Motion in the x direction
figure(1)
plot(t,x);
xlabel('time')
ylabel('ξ')
title('Motion in the x direction')

%% Motion in the y direction
figure(2)
plot(t,y);
xlabel('time')
ylabel('η')
title('Motion in the y direction')

%% Motion in the z direction
figure(3)
plot(t,-z);
xlabel('time')
ylabel('ζ')
title('Motion in the z direction')

%% Submarine trajectory
figure(4)
plot3(x,y,-z);
xlabel('ξ')
ylabel('η')
zlabel('ζ')
title('Submarine trajectory')