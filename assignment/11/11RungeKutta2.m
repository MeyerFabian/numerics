source "../../general/explicitMethods.m"
x = [0:0.01:3.0];
dy = @(t,y) (-y); 
y0=1;
t0=0;
h1=0.5;
n1=(x(end)-x(1))/h1;
h2=1/8;
n2=(x(end)-x(1))/h2;
h3=1/32;
n3=(x(end)-x(1))/h3;

butcher= [  0,0.5,0.5, 1,0; 
            0,0.5,0  , 0,1/6;
            0,0  ,0.5, 0,1/3 ;
            0,0  ,0  , 1 1/3;
            0,0  ,0  , 0 1/6];
[t,y] = explRungeKutta(butcher,y0,t0,dy,h1,n1);
[t2,y2] = explRungeKutta(butcher,y0,t0,dy,h2,n2);
plot(x,e.^(-x),t,y,'o',t2,y2,'.')
title("Solution of y'=-y");
legend("analytic:e^{-x}","RK4 h=0.5","RK4 h=0.125");