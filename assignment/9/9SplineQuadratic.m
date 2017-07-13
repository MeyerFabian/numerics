source "../../general/splines.m"
x = [0:0.05:3.0];
tx=[0, 1, 2, 3];
c=[0, 0, 1, 0, 0];
k=3;


y=[];
clf;
hold on;

for(i=1:length(x))
    y(i) = bSplineInterp(x(i),tx,c,k);
end  
plot(x,y)