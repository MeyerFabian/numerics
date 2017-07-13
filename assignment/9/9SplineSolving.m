source "../../general/splines.m"
x = [0:0.01:1.0];
tx=[0,0.1,0.3,0.45,0.65,0.8,1];
c=[1,0.5,.3,-.1,-0.6,0,0.7,1.0,0.2];
k=4;


y=[];
clf;
hold on;

for(i=1:length(x))
    y(i) = bSplineInterp(x(i),tx,c,k);
end  
plot(x,y)