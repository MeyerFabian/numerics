source "../../general/splines.m"
x = [0:0.01:1.0];
tx=[0:0.1:1.0];
f=[0:0.1:1.0];
dfa = 1;
dfb = 1;
k=4;
y = zeros(1,length(x));
c = BSplineInterpCubicFirstDerivative(tx,f,dfa,dfb);

clf;
hold on;
plot(tx,f,'o')
for(i=1:length(x))
    y(i) = bSplineInterp(x(i),tx,c,k);
end  
plot(x,y)
title("cubic spline-interpolation for y=x");
legend("datapoints","spline");
#plot(x,y)
#plot(tx,f,'o');