#newton method for arbitrary dimensions
#f : function of which to find a root (0,...,0) of dimension (m x 1)
#x : starting value of the fixpoint iteration (n x 1)
#fd: the jacobian matrix of f of dimension (m x n)
#k : the number of iterations
function x = newton(x,f,fd,k)
  for(it=1:k)
    F  = [];
    Fd = [];
    for(i=1:ndims(f))
    F = [F f{i}(x)];
    end
    for(i=1:rows(fd))
      v=[];
      for(j=1:columns(fd))
      v = [v fd{i,j}(x)];
      end
      Fd = [Fd; v];
    end
    s = -F / Fd';
    x = x + s;
  end
end