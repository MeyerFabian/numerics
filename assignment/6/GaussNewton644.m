source "../../general/gaussnewton.m"
source "../../general/simpleFunctions.m"
#functions given
x = [0.5,0.5];
t = [0.1:0.1:0.3];
b = [0.395,0.134,-0.119];
n=10;
#C=x(1), lamda =x(2)
y1 = @(x,t) (x(1)*exp(x(2)*t)).*(cos(2*pi*t));
f1 = @(x,t,b) y1(x,t)-b;

fd1x = @(x,t,b) (exp(x(2)*t)).*(cos(2*pi*t));
fd1y = @(x,t,b) (x(2)*x(1)*exp(x(2)*t)).*(cos(2*pi*t));

f1(x,t,b)

F1 = {f1};
Fd1 = {fd1x ; fd1y};
#newton root finding
root = gaussnewton(F1,Fd1,n,x,t,b);
xt= [0.0:0.02:0.3];
plot(t,b,'o',xt,y1(root,xt));

