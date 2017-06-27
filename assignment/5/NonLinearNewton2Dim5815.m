source "../../general/newton.m"
source "../../general/simpleFunctions.m"
x1 = [0 0];
x2 = [1 1];
n=10;

#functions given
f1 = @(x) x(1).^2-x(2)-1;
f2 = @(x) (x(1)-2).^2 + (x(2)-0.5).^2-1;

#calculated derivatives
df1x = @(x) 2*x(1);
df1y = @(x) -1;
df2x = @(x) 2*(x(1)-2);
df2y = @(x) 2*(x(2)-0.5);

#cell arrays to store function handles
F1 = {f1; f2} ;

Fd1 = { df1x, df2x;
        df1y, df2y};
        
#newton root finding
root1 = newton(F1,Fd1,n,x1);
root2 = newton(F1,Fd1,n,x2);

#errors
f1(root1)
f1(root2)
f2(root1)
f2(root2)

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

plot3([root1(1)  root1(1)], [root1(2) root1(2)], [-5 5], '-');
hold on;
plot3([root2(1)  root2(1)], [root2(2) root2(2)], [-5 5], '-');

mesh (tx, ty, tz);

mesh (tx, ty, tz2);
hold off;

