#spline function of k=4 (cubic spline)
function s= cubicSplineInterp(x,x_start,x_end,y_start,y_end,m_start,m_end,h)
  s = ((x_end-x).^3.*m_start + (x-x_start).^3.*m_end)/(6*h);
  s += ((x_end-x).*y_start + (x-x_start).*y_end)/(h);
  s -= h/6*((x_end-x).*m_start + (x-x_start).*m_end);
end

#creates interpolation splines for given x and f(x) if x is equally spaced with h
function m = cubicSplineCreation(x,y,h)
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

function j = sId(j,p)
  j=(j-1)*(j)/2+p;
end

function cjpx = calcCjpx(cj,j,p,m,k,tx,x)
  b = min(max(m+j-k,1),length(tx));
  e= max(min(m+j-p+1,length(tx)),1);
  cjpx = (x - tx(b)) / (tx(e) - tx(b)) *cj(sId(j,p-1))+(tx(e)-x) / (tx(e) - tx(b)) *cj(sId(j-1,p-1));
end

function s = splineInterp(x,tx,c,k)
  m=1;
  t=length(tx);
  for(j=1:t)
    if(tx(j)>x)
    m=j-1;
    break;
    endif;
  end;
  for(j=1:k)

    cj(sId(j,1))=c(m+j-1);
    for(p=2:j)
    cj(sId(j,p)) = calcCjpx(cj,j,p,m,k,tx,x);
    end
  end
  s=cj(end);
end