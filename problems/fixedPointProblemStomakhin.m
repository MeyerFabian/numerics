# steepness constraint as in
# http://alexey.stomakhin.com/research/siggraph2017_fab.pdf page 5

source "../general/simpleFunctions.m"
#f is the function where we look for a zero crossing between [1,1.5]
f = @(x) (2*x.*(1+3/2.*x.^2*pi^2));


#h is the fixed point problem by newtons method 
h = @(x) (x-(2*x.*(1+3/2*x.^2*pi^2)-0.1412)./(2+9*x*pi^2));



#iterate to find zero crossing
nh = iterate (h,40,0.0);

errorOf_h = f(nh)-0.1412

#h therefore has quadratic convergence (due to newton)
#whereas g has only linear convergence
y = [0:0.001:0.1];
plot(y,f(y),nh,f(nh))

nh