# Painless conjugate gradient, Jonathan Richard Shewchuk
function x = conjugated_gradients(A,b,x,n=0)

[n,r,d] = init_conjugated_gradients(A,b,x,n);
for i = 1:n
	[x,r,d] = step_conjugated_gradients(A,b,x,r,d);
end;
endfunction;


function X = conjugated_gradients_stepwise(A,b,x,n=0)

[n,r,d] = init_conjugated_gradients(A,b,x,n);

X=x;
for i = 1:n
	[x,r,d] = step_conjugated_gradients(A,b,x,r,d);
	X = [X,x];
end;
endfunction;


function [n,r,d] = init_conjugated_gradients(A,b,x,n=0)

if(n==0)
	# maximum steps of conjugated gradients
	n = size(A,2);
end;
# calculate residual
r = b-A*x;
# do first search direction residual
d = r;
endfunction;

function [x,r,d] = step_conjugated_gradients(A,b,x,r,d)
# Precompute Ad
Ad = A * d;
# Line search minimization offset
alpha = (r'*r) / (d'*Ad);
# Go to minimum
x = x + alpha * d;
# Calculate new residual for new minimum
next_r = r - alpha *Ad;
# Offset search direction from residual
beta = (next_r' * next_r)/(r'*r);
# Find new a-orthogonal search direction
d = next_r + beta * d;
# Trash temporary r_{i+1}
r = next_r;
endfunction;
