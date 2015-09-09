clc; clear all; 
% Three points 
P1 = [1,-1,3]; 
P2 = [2,3,4]; 
P3 = [-5,6,7]; 
P=[P1;P2;P3]'; 
plot3(P(1,:),P(2,:),P(3,:),'O'); 
% calculate the function of the plane through the 3 points 
normal = cross(P1-P2, P1-P3); 
syms x y z; 
P = [x,y,z]; 
planefunction = dot(normal, P-P1); 
zplane = solve(planefunction, z); 
% Display 
axis([-5, 5, -4, 6, 0, 8]); 
%P = [zeros(1,3);P1;P2;P3]; 
%plot3(P([1 2],1),P([1 2],2),P([1 2],3),'-ko','markerfacecolor','k'); hold on; 
%plot3(P([1 3],1),P([1 3],2),P([1 3],3),'-ko','markerfacecolor','k'); hold on; 
%plot3(P([1 4],1),P([1 4],2),P([1 4],3),'-ko','markerfacecolor','k'); hold on; 
ezmesh(zplane,50);