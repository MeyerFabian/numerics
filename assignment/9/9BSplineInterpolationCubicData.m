source "../../general/splines.m"
x = [0:0.01:1.4];
tx=[0:0.1:1.4];
f=[ones(1,6),0.5*(ones(1,9))];
dfa = 0;
dfb = 0;
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
title("cubic spline-interpolation for heaviside-type function");
legend("datapoints","spline");
#plot(x,y)
#plot(tx,f,'o');