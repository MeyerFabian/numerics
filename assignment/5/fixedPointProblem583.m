source "../../general/simpleFunctions.m"
#f is the fixed point function
f = @(x) exp(x).*(x-1)./(4*(x+2));

fd = @(x) exp(x).*(x.^2+x+1)./(4.*(x+2).^2);
y = [-1:0.01:0];

nf = iterate (f,5,0)

plot(y,f(y),y,fd(y),nf,f(nf))
