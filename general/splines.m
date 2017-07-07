#spline function of k=4 (cubic spline)
function s= spline(x,x_start,x_end,y_start,y_end,m_start,m_end,h)
  s = ((x_end-x).^3.*m_start + (x-x_start).^3.*m_end)/(6*h);
  s += ((x_end-x).*y_start + (x-x_start).*y_end)/(h);
  s -= h/6*((x_end-x).*m_start + (x-x_start).*m_end);
end

#creates interpolation splines for given x and f(x) if x is equally spaced with h
function m = splineCreation(x,y,h)
  n = length(x)-2;
  u_d = [zeros(n-1,1),diag(ones(1,n-1));zeros(1,n)];
  l_d = [zeros(1,n);diag(ones(1,n-1)),zeros(n-1,1)];
  A = diag(4*ones(1,n)) +u_d +l_d;
  b= [];
  for(i=1:n)
    b(i)=6/(h*h)*(y(i)-2*y(i+1)+y(i+2));
  end
  m = b/A;
  m = [0,m,0];
end 
