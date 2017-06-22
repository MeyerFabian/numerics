source "../../general/simpleFunctions.m"
#f is the function where we look for a zero crossing between [1,1.5]
f = @(x) (2*x - tan(x));

#g is a fixed point problem for f and global convergent on [1,1.5]
g = @(x) (atan(2*x));
#first derivative (monotonically decreasing) so L is at x=1, g'(1)= 0.4 = L
# L can be used for aposterio and apriori estim.
gd = @(x) (2./(4*x.^2+1));


#h is the fixed point problem by newtons method 
h = @(x) ((-x*sec(x)*sec(x) +tan(x))/(2-sec(x)*sec(x)));



#iterate to find zero crossing
ng = iterate (g,10,1.2);
nh = iterate (h,10,1.2);

errorOf_g = f(ng)
errorOf_h = f(nh)

#h therefore has quadratic convergence (due to newton)
#whereas g has only linear convergence

y = [1:0.01:1.5];
plot(y,f(y),y,g(y),ng,f(ng),nh,f(nh))
