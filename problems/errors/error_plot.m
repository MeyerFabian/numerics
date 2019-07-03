clear ; close all; clc
gamma = @(k,eps) (k*eps)./(1-k*eps);

labels = {};
hold on;
for k = 1:20;
	eps = [0:0.01:(1/k)];
	plot(eps,gamma(k,eps));
	labels = {labels{:},["k=",num2str(k)]};
end;
legend(labels);
hold off;
