source "../../general/gaussnewton.m"
source "../../general/simpleFunctions.m"
#functions given
x = [0];
t = [0.2:0.2:1.0];
b = [1.55,1.65,1.8,1.95,2.1];
n=10;
y1 = @(x,t) 2*x(1)+sqrt(x(1)^2+t.^2);
f1 = @(x,t,b) y1(x,t)-b;
fd1x = @(x,t,b) 2+x(1)./(sqrt(x(1)^2+t.^2))

F1 = {f1};
Fd1 = {fd1x};
#newton root finding
root = gaussnewton(x,F1,Fd1,n,t,b);
xt= [0.0:0.05:1.0];
plot(t,b,'o',xt,y1(root,xt));

