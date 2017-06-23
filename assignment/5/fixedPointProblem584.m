source "../../general/simpleFunctions.m"

# f is what we want to solve on [0,1]
# luckily f is strictly montonically decreasing
# x=0 => 1/3 and x=1 => -2/3
# Bolzano theorem + smd. => there exists exactly one root 
h = @(x) 1/8*sin(2*pi*x)+(1/3)-x;
hd = @(x) (1/4*pi*cos(2*pi*x)-1);

#g is a linear convergent fixed point function
g = @(x) 1/8*sin(2*pi*x)+(1/3);

#f is the fixed point function by newtons method
f = @(x) x-(1/8*sin(2*pi*x)+(1/3)-x)/(pi/4*cos(2*pi*x)-1);
nf = iterate (f,12,0)
ng = iterate (g,12,0)

y = [0:0.01:1];
plot(y,h(y),y,(h(y+0.01)-h(y))/0.01,y,hd(y),nf,h(nf),ng,h(ng))
