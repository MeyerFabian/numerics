# apply function f n times => f(f(...f(x)...))
function x = iterate(f,n,x)
  for i=1:n
  x = f(x);
  end
end

