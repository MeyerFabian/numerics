# apply function f n times => f(f(...f(x)...))
function x = iterate(f,n,x)
  for i=1:n
  x = f(x);
  end
end

function F = evalFMatrix(f,x,varargin)
  F = [];
  for(i=1:rows(f))
    v=[];
    for(j=1:columns(f))
    v = [v, (f{i,j}(x,varargin{:}))];
    end
  F = [F; v];
  end
end

function x = solveLinearSystem(F,Fd,x)
    s = -F / Fd;
    x = x + s;
end