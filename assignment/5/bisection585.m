source "../../general/bisection.m"
# p is what we want to solve on [0,1]
p = @(x) x.^3-x+0.3;

z=bisection(p,-2,-0.5,20);
x=bisection(p,-0.5,0.5,20);
o=bisection(p,0.5,1,20);

y = [-2:0.05:1];
plot(y,p(y),x,p(x),'.',z,p(z),'.',o,p(o),'.')

#roots are then
roots= [(z(end,1)+z(end,2))/2 (x(end,1)+x(end,2))/2 (o(end,1)+o(end,2))/2]