#newton method for arbitrary dimensions
#f : function of which to find a root (0,...,0) of dimension (m x 1)
#x : starting value of the fixpoint iteration (n x 1)
#fd: the jacobian matrix of f of dimension (m x n)
#k : the number of iterations
function x = newton(f,fd,k,x,varargin)
  for(it=1:k)
    F = evalFMatrix(f,x,varargin{:});
    Fd = evalFMatrix(fd,x,varargin{:});
    x = solveLinearSystem(F,Fd,x);
  end
end