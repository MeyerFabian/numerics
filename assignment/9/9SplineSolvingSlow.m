source "../../general/splines.m"
x = [0:0.01:1.0];
tx=[0,0.1,0.3,0.45,0.65,0.8,1];
c=[1,0.5,.3,-.1,-0.6,0,0.7,1.0,0.2];
k=4;

N=[];
y=zeros(1,length(x));
clf;
hold on;
for(j=1:length(tx)+k-2)
  for(i=1:length(x))
  N(i) = bspline(tx,x(i),j,k);
  y(i) += N(i)*c(j);
  end
  #plot(x,N);
end
plot(x,y)