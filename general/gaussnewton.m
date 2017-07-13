#gaussnewton method for arbitrary dimensions
#f : function of which to find a minimum of dimension (m x 1)
#x : starting parameters of the fixpoint iteration (n x 1)
#fd: the jacobian matrix of f of dimension (m x n)
#k : the number of iterations
#gradF : gradient of f
#sHF: is the simplified Hessian ignoring squared terms
function x = gaussnewton(f,fd,k,x,varargin)
  for(it=1:k)
    F = evalFMatrix(f,x,varargin{:});
    Fd = evalFMatrix(fd,x,varargin{:});
    gradF = F * Fd' ;
    sHF =  Fd *Fd';
    x = solveLinearSystem(gradF,sHF,x);
  end
end