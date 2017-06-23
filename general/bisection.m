#bisection algorithm
function [a,b] = bisection2(func,a,b)
  half_point = (a+b)/2;
  if(abs(func(half_point))<eps)
    a= half_point;
    b= half_point;
  elseif(sign(func(half_point))==sign(func(a)))
    a=half_point;
  else
    b=half_point;
  endif
end  

function x = bisection(func,a,b,n)
  if(a>b)
    t=b;
    b=a;
    a=t;
  endif
  x=[a b];
  for i=1:n
  [a,b] = bisection2(func,a,b);
  x=[x;a b];
  end
end 