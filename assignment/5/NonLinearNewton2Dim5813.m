source "../../general/newton.m"
source "../../general/simpleFunctions.m"
x = [1,1];
n=10;

#functions given
f1 = @(x) 4*x(1).^3-27*x(1).*x(2).^2+25;
f2 = @(x) 4*x(1).^2-3*x(2).^2-1;

#calculated derivatives
df1x = @(x) 12*x(1).^2-27*x(2).^2;
df1y = @(x) -54.*x(2);
df2x = @(x) 8*x(1);
df2y = @(x) -9*x(2).^2;

#cell arrays to store function handles
F1 = {f1, f2} ;

Fd1 = { df1x, df2x ;
        df1y, df2y};

#newton root finding
root = newton(F1,Fd1,n,x)

#errors
f1(root)
f2(root)

#we are finished here with newton next is just bunch of graphics
# in the middle of the sphere 
tx = ty = linspace (0, 2, 10)';
[xx, yy] = meshgrid (tx, ty);

tz=[];
for(i=1:rows(xx))
   for(j=1:columns(yy))
     tz(i,j) = f1([ xx(i,j) yy(i,j)]);
   end
end

tz2=[];
for(i=1:rows(xx))
   for(j=1:columns(yy))
     tz2(i,j) = f2([ xx(i,j) yy(i,j)]);
   end
end

plot3([root(1)  root(1)], [root(2) root(2)], [-50 50], '-');
hold on;
mesh (tx, ty, tz);

mesh (tx, ty, tz2);

hold off;
