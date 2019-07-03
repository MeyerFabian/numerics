clear;clf;
source "../general/conjugated_gradients.m"

A = [3,2;2,6];
b = [2;-8];
[x1,x2] = meshgrid([-4:0.1:6],[-6:0.1:4]);
X = [x1(:)';x2(:)'];
r = A*X-b;
e = 0.5 * norm(r,2,'cols').^2;
contour(x1,x2,reshape(e,size(x1)),levels = [20 40 80 160 320 640],'ShowText','on');
hold on;

x_0 = [-2;-2];
x_i = conjugated_gradients_stepwise(A,b,x_0);
plot(x_i(1,:),x_i(2,:),'ro-');
text(x_0(1),x_0(2),'x0');
text(2,-2,'x');
hold off;
