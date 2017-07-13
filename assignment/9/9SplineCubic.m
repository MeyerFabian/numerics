source "../../general/splines.m"
x = [-2:0.05:2.0];
tx=[-2, -1, 0, 1, 2];
c=[0, 0, 0, 6, 0, 0, 0];
k=4;


y=[];
clf;
hold on;

for(i=1:length(x))
    y(i) = bSplineInterp(x(i),tx,c,k);
end  
plot(x,y)