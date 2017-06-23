#bisection algorithm
function x = bisection2(func,x)
    half_point = (x(1)+x(2))/2;
  if(abs(func(half_point))<eps)
    x(1)= half_point;
    x(2)= half_point;
  elseif(sign(func(half_point))==sign(func(x(1))))
    x(1)=half_point;
  else
    x(2)=half_point;
  endif
end  

function x = bisection(func,x,n)
  if(x(1)>x(2))
    t=x(1);
    x(1)=x(2);
    x(2)=t;
  endif
  for i=1:n
  y = bisection2(func,[x(end,1) x(end,2)]);
  x=[x;y];
  end
end 