source "../../general/splines.m"
x = [0:0.01:1.0];
tx=[0,0.1,0.5,0.9,1.0];
k=4;


y=[];
clf;
hold on;
for(j=1:length(tx)+k-2)
  for(i=1:length(x))
  N(i) = bSpline(tx,x(i),j,true,k);
  end
  plot(x,N);
end