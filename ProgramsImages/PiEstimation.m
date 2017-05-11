%% Estimate time
tic
n = 1e7;
a = rand(n,2);
piEst = 3*mean(a(:,1).^2 + a(:,2).^2 >= 1)
toc