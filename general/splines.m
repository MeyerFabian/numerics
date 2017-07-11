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

function i = tId(i,minimum,maximum)
  i = min(max(i,minimum),maximum);
end

function cjpx = calcCjpx(cj,j,p,m,k,tx,x)
  bg = tId(m+j-k,1,length(tx));
  ed = tId(m+j-p+1,1,length(tx));
  cjpx = (x - tx(bg)) / (tx(ed) - tx(bg)) *cj(sId(j,p-1))+(tx(ed)-x) / (tx(ed) - tx(bg)) *cj(sId(j-1,p-1));
end

function s = splineInterp(x,tx,c,k)
  m=1;
  t=length(tx);
  if(x==tx(end))
    s= c(end);
    return;
  end
  
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

function N = bsplineRec(tx,x,j,k)
  if(k==1)
    bg = tId(j,1,length(tx));
    ed = tId(j+1,1,length(tx));
    if(tx(bg)<=x && tx(ed)>x)
      N=1;
    else
      N=0;
    end
  else
    b1 = tId(j,1,length(tx));
    e1 = tId(j+k-1,1,length(tx));
    b2 = tId(j+1,1,length(tx));
    e2 = tId(j+k,1,length(tx));
    N=0;
    
    if(b1==e1)
      g1 = 0;
    else
      g1 =(x-tx(b1))/(tx(e1)-tx(b1));
    end
    if(b2==e2)
      g2 = 0;
    else
      g2 =(tx(e2)-x)/(tx(e2)-tx(b2));
    end
    N= (g1)*bsplineRec(tx,x,j,k-1) +(g2)*bsplineRec(tx,x,j+1,k-1);  
  end
    
end

function N = bspline(tx,x,j,k)

  bg = tId(j,1,length(tx));
  ed = tId(j+k,1,length(tx));
    
  if(x==tx(end) && j==length(tx)-1)
    N=1;
    break;
  end;

  if(tx(bg)>x && tx(ed)<=x)
    N=0;
    break;
  end
  N=bsplineRec(tx,x,j,k);
end

