
#newton method for arbitrary dimensions
#f : function of which to find a minimum of dimension (m x 1)
#x : starting value of the fixpoint iteration (n x 1)
#fd: the jacobian matrix of f of dimension (m x n)
#k : the number of iterations
function x = gaussnewton(x,f,fd,k,varargin)
  for(it=1:k)
    F = evalFMatrix(f,x,varargin{:});
    Fd = evalFMatrix(fd,x,varargin{:});
    gradF = Fd' *F;
    sHF = Fd' *Fd;
    x = solveLinearSystem(x,gradF,sHF);
  end
end