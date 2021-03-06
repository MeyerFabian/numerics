source "../../general/splines.m"
#functions given
h = 1;
x = 3:h:10;
y = [2.5 2.0 0.5 0.5 1.5 1.0 1.125 0.0];

m = cubicSplineCreation(x,y,h);

n = length(x)-1;
plot(x,y,'o');
hold on;
for(i=1:n)
  sx = [x(i):(h*0.1):x(i+1)];
  sy = cubicSplineInterp(sx,x(i),x(i+1),y(i),y(i+1),m(i),m(i+1),h);
  plot(sx,sy);
end
hold off;


