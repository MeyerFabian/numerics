# converts index of two dimensional quadratic lower triagonal matrix A (row major) into one dimensional index
#         i= 1,2,3
# A(i,j) = ( 1 0 0   j=1
#            2 3 0   j=2
#            4 5 6 ) j=3
# i: row number
# j: column number
function i = sId(i,j)
  i=(i-1)*(i)/2+j;
end

# cuts the index between minimum and maximum
# ex: tId(-1,1,5) = 1
#     tId( 7,1,5) = 5
#     tId( 3,1,5) = 3
function i = tId(i,minimum,maximum)
  i = min(max(i,minimum),maximum);
end

# (9.16) c_j^[p] is the coefficient that is created out of the convex combination of lower dimensional cj's
# cj: neville aitken scheme vectorize
#  j: j-te coefficient
#  p: dimension of c
#  m: index of nearest data point below x 
#  k: dimension of the spline
#  tx:data points
#  x: point to interpolate
function cjpx = calcCjpx(cj,j,p,m,k,tx,x)
  bg = tId(m+j-k,1,length(tx));
  ed = tId(m+j-p+1,1,length(tx));
  cjpx = (x - tx(bg)) / (tx(ed) - tx(bg)) *cj(sId(j,p-1))+(tx(ed)-x) / (tx(ed) - tx(bg)) *cj(sId(j-1,p-1));
end

# (Algorithm 9.12) calculation of the interpolation for the piecewise spline function
# x : point to interpolate
# tx: data points
# c : coefficients of piecewise spline function
# k : dimension of spline
function s = bSplineInterp(x,tx,c,k)
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


# Calculates the value of the j-th b-spline at point x
# tx    : data points
# x     : point to interpolate
# j     : j-te bspline
#         where t:= length(tx).
# k     : dimension of bspline
function N = bSplineRec(tx,x,j,k)
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
    N= (g1)*bSplineRec(tx,x,j,k-1) +(g2)*bSplineRec(tx,x,j+1,k-1);  
  end
    
end

# Helper function: initializes recursion for calculating the value of the j-th b-spline
# and handles edge cases + preprocessing
# tx    : data points
# x     : point to interpolate
# j     : j-te bspline
# j_reId: is j reindex or no, before reindex N(j,k), 1<j<t+k-2
#                             after reindex  N(j,k), 1-(k-1)<j<t+k-2-(k-1) = 2-k<j<t-1
#         where t:= length(tx).
# k     : dimension of bspline
function N = bSpline(tx,x,j,j_reId,k)
  if(j_reId)
    j = j-(k-1);
  end
  bg = tId(j,1,length(tx));
  ed = tId(j+k,1,length(tx));
    
  if(x==tx(end) && j==length(tx)-1)
    N=1;
    return;
  end;

  if(tx(bg)>x && tx(ed)<=x)
    N=0;
    return;
  end
  N=bSplineRec(tx,x,j,k);
end

# (Folgerung 9.8) Calculates derivative of a B-Spline at point x
# tx    : data points
# x     : point to interpolate
# j     : j-te bspline
# j_reId: is j reindex or no, before reindex N(j,k), 1<j<t+k-2
#                             after reindex  N(j,k), 1-(k-1)<j<t+k-2-(k-1) = 2-k<j<t-1
#         where t:= length(tx).
# k     : dimension of bspline
# dx    : the dx-th derivative
function dN = bSplineDeriv(tx,x,j,j_reId,k,dx)
  if(j_reId)
    j = j-(k-1);
  end
  if(dx==0)
    dN= bSpline(tx,x,j,false,k);
  else
    b1 = tId(j,1,length(tx));
    e1 = tId(j+k-1,1,length(tx));
    b2 = tId(j+1,1,length(tx));
    e2 = tId(j+k,1,length(tx));
    
    if(b1==e1)
      g1 = 0;
    else
      g1 =bSplineDeriv(tx,x,j,false,k-1,dx-1)/(tx(e1)-tx(b1));
    end
    if(b2==e2)
      g2 = 0;
    else
      g2 =bSplineDeriv(tx,x,j+1,false,k-1,dx-1)/(tx(e2)-tx(b2));
    end
    dN= (k-1)*(g1-g2);  
  end
end

# (Satz 9.19) Calculates the cubic spline interpolation which goes through data points (tx,f(tx))
# boundary conditions are f'(a) = S'(a) and f'(b) = S'(b) where a=min(tx) and b=max(tx)
# tx   : data points
# f    : values of data points tx
# dfa  : f'(a)
# dfa  : f'(b)
function c = BSplineInterpCubicFirstDerivative(tx,f,dfa,dfb)
  k=4;
  c=zeros(1,length(f));
  A=[];
  N=[];
  
  c1 = f(1);
  c2 = (dfa - f(1)*bSplineDeriv(tx,tx(1),1,true,k,1))/ bSplineDeriv(tx,tx(1),2,true,k,1);
  c3 = (dfb - f(end)*bSplineDeriv(tx,tx(end),length(tx)+2,true,k,1))/ bSplineDeriv(tx,tx(end),length(tx)+1,true,k,1);
  c4 = f(end);

  f_ = f(2:end-1);
  f_(1) -=c2*bSpline(tx,tx(2),2,true,k);
  f_(end) -=c3*bSpline(tx,tx(length(tx)-1),length(tx)+1,true,k);

  for(j=3:length(tx))
    for(i=2:length(tx)-1)
    N(i-1) = bSpline(tx,tx(i),j,true,k);
    end
    A = [A;N];
  end
  c = f_/A;

  c =[c1,c2,c,c3,c4];

end

# cubic spline for intervall [a,b] a <= x <= b
# a: a data points
# b: next(!) neighbor data point
# ma: f''(a)
# mb: f''(b)
# h: spacing
function s= cubicSplineInterp(x,a,b,fa,fb,ma,mb,h)
  s = ((b-x).^3.*ma + (x-a).^3.*mb)/(6*h);
  s += ((b-x).*fa + (x-a).*fb)/(h);
  s -= h/6*((b-x).*ma + (x-a).*mb);
end

# creates cubic interpolation splines for given x and y=f(x) if x is equally spaced with h
# x: equally spaced points
# y: f(x)
# h: spacing
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
