#bisection algorithm
function x = newton(x,f,fd,n)

  for(it=1:n)
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