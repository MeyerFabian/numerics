# explicit runge kutta from butcher tableau 
#(explicit = butcher tableau is upper triagonal matrix)
# y0 = y(0)
# t0 = t(0)
# dy = y' (derivative)
# h : stepsize
# n : number of steps
function [t,y] = explRungeKutta(butcher,y0,t0,dy,h,n)
  alpha = butcher(1,1:end-1);
  gamma =  transpose(butcher(2:end,end));
  beta=    butcher(2:end,1:end-1);
  y=[y0];
  t=[t0];
  for(i = 1:n)  
    y(i+1) =y(i);
    t(i+1) =t(i)+h;
    for(j = 1:size(beta))
      u(j) = y(i);
      for(k =1:j-1)
        u(j) += h*beta(k,j)*dy(t(i)+alpha(k)*h,u(k));
      end
    y(i+1) += h *gamma(j)*dy(t(i)+alpha(j)*h,u(j));
    end
  end
end  
