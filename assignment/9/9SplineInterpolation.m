source "../../general/splines.m"
x = [0:0.01:1.4];
tx=[0:0.1:1.4];
f=[ones(1,6),0.5*(ones(1,9))];
k=4;
A=[];
N=[];
y=zeros(1,length(x));
c=zeros(1,length(f));

c1 = f(1);
c2 = 1;
c3 = 0.5;
c4 = f(end);

f_ = f(2:end-1);
f_(1) -=c2*bspline(tx,tx(2),2,k);
f_(end) -=c3*bspline(tx,tx(length(tx)-1),length(tx)+1,k);

for(j=3:length(tx))
  for(i=2:length(tx)-1)
  N(i-1) = bspline(tx,tx(i),j,k);
  end
  A = [A;N];
end
c = f_/A;

c =[c1,c2,c,c3,c4];

y=[];
clf;
hold on;
plot(tx,f,'o')
for(i=1:length(x))
    y(i) = splineInterp(x(i),tx,c,k);
end  
plot(x,y)

#plot(x,y)
#plot(tx,f,'o');