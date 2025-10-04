close all;
clear all;
clc;
format long;
name = 'Jared Admiraal';
id = 'A17823463';
hw_num = 'project';

m=0.625;
r=0.12;
A=pi*r^2;
drim=0.46;
rho=1.2;
g=9.81;
Cd=0.3;
Cm=0.13;
colors = ['b','g','r','c','m','y','k'];
load('court_geometry.mat');

figure(1);
hold on;
plot3(Xcourt,Ycourt,Zcourt,'.','color',[0.5 0.2 0.3]);
plot3(Xrim,Yrim,Zrim,'-','color',[.8 0 0.8]);
plot3(Xboard,Yboard,Zboard,'.','color',[1 0.9 1]);
box on; grid on; axis tight; axis equal;
xlabel('x (m)'); ylabel('y (m)'); zlabel('z (m)');
title('Basketball Court');
view(3); 
set(gca,'FontSize',16);


for n = 1:7
    [Xo, Yo, Zo, Umag0, theta, phi, omgX, omgY, omgZ]=read_input('test_study_parameter.txt',n);
    [T, X, Y, Z, U, V, W, status] = basketball(Xo, Yo, Zo, Umag0, theta, phi, omgX, omgY, omgZ);
    plot3(Xo,Yo,Zo,'*','Color',colors(n),'LineWidth',1);
    lgnd(n) = plot3(X,Y,Z,'-','Color',colors(n),'LineWidth',2);
    plot3(X(end),Y(end),Z(end),'o','MarkerFaceColor',colors(n),'MarkerEdgeColor',colors(n),'MarkerSize',5);
    ball_stat(n) = struct('shot_number',n,'time',T(end),'max_height_position',[X(Z==max(Z)),Y(Z==max(Z)),Z(Z==max(Z))],'landing_position',[X(end),Y(end),Z(end)],'landing_speed',sqrt(U(end)^2+V(end)^2+W(end)^2),'travel_distance',sum(sqrt(diff(X).^2+diff(Y).^2+diff(Z).^2)));
end
xlabel('x (m)');
ylabel('y (m)');
zlabel('z (m)');
title('Trajectories of the basketballs');
legend(lgnd,{'Shot #1','Shot #2','Shot #3','Shot #4','Shot #5','Shot #6','Shot #7'},'Location','northwest','FontSize',8,'Box','off');
hold off;

header = 'shot_number, travel time(s), landing_speed(m/s), travel_distance(m)';
fid = fopen('report.txt','w');
fprintf(fid, '%s\n',name);
fprintf(fid, '%s\n',id);
fprintf(fid, '%s\n',header);
for n = 1:7
    fprintf(fid,'%d %15.9e %15.9e %15.9e\n',ball_stat(n).shot_number,ball_stat(n).time,ball_stat(n).landing_speed,ball_stat(n).travel_distance);
end
fclose('all');

filename2 = 'best_angle_study_parameter.txt';
figure(2);
hold on;
for n = 1:1200  
    [Xo, Yo, Zo, Umag0, theta, phi, omgX, omgY, omgZ] = read_input(filename2,n);
    [T, X, Y, Z, U, V, W, status] = basketball(Xo, Yo, Zo, Umag0, theta, phi, omgX, omgY, omgZ);
    if status == 1
        plot(Zo,phi,'ro','MarkerFaceColor','red','MarkerSize',5);
    else
        plot(Zo,phi,'ko','MarkerFaceColor','black','MarkerSize',5);
    end
end
title('Optimal Angle Study: good (red) and missed (black) shots');
xlabel('Initial release height Zo (m)');
ylabel('Shooting angle (degree)');
hold off;

p1 = 'See figure 1';
p2a = ball_stat(1);
p2b = ball_stat(2);
p2c = ball_stat(3);
p2d = ball_stat(4);
p2e = ball_stat(5);
p2f = ball_stat(6);
p2g = ball_stat(7);
p3 = evalc('type report.txt');
p4 = 'See figure 2';

