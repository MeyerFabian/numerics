source "../../general/splines.m"
x = [-1:0.01:1.0];
tx=[-1:0.1:1.0];
f= @(x) x.^2;
df= @(x) 2*x;
k=4;
y = zeros(1,length(x));
c = BSplineInterpCubicFirstDerivative(tx,f(tx),df(tx(1)),df(tx(end)));

clf;
hold on;
plot(tx,f(tx),'o')
for(i=1:length(x))
    y(i) = bSplineInterp(x(i),tx,c,k);
end  
plot(x,y)
title("cubic spline-interpolation for y=x²");
legend("datapoints","spline");
#plot(x,y)
#plot(tx,f,'o');