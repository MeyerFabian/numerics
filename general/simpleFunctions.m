# apply function f n times => f(f(...f(x)...))
function x = iterate(func,n,x)
  for i=1:n
  x = func(x);
  end
end

