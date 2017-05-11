%% Average Distance Between Points Using CLT Confidence Intervals

%% A simple, concrete example  
% Recall again the problem of determining the average distance between two
% points in a unit square.  The true answer is a 4-dimensional integral
% 
% \[ \mu = \int_{[0,1]^2 \times [0,1]^2} \sqrt{(x_1-y_1)^2 +
% (x_2-y_2)^2} \, {\rm d}x_1 \, {\rm d}x_2 \, {\rm d}y_1 \, {\rm d}y_2\]
% 
% We talked about how to compute the answer using Monte Carlo methods.
% First we define a mean distance function as follows

distfun = @(n) sqrt(sum((rand(n,2)  - rand(n,2)).^2,2));

%% 
% To approximate the answer, \(\mu\), we may use the sample mean with |n =
% 1e6| points.  This is the Monte Carlo method

tic, meandist = mean(distfun(1e6)), toc

%%
% The problem is that we do not yet know how accurate our answer is.

%% Central Limit Theorem (CLT) confidence intervals
% The probability distribution of the sample mean with \(n\) samples of IID
% \(Y_i\) approaches the Gaussian (or normal) distribution with mean $E(Y)$
% and variance $\mbox{var}(Y)/n$.  This idea is behind the algorithm
% |meanMC_CLT|
%
% <include>meanMC_CLT.m</include>

%% 
% We may use this algorithm to find a fixed-width confidence interval

tic, meandist = meanMC_CLT(distfun,0.02), toc %absolute error tolerance = 0.02

%%
% Note that the time required by |meanMC_CLT| is less than that required by
% taking the mean of 1e6 samples.  To find out how many samples
% |meanMC_CLT| actually used, we may try

[meandist,output] = meanMC_CLT(distfun,0.02)

%%
% The value of |output.ntot| is the total number of samples used.

%% Sometimes the CLT confidence interval does not work
% Unfortunately, |meanMC_CLT| does not have solid theoretical support.
% E.g. consider the example

a=300; % a parameter
Y = @(n) randn(n,1) + a*(a*rand(n,1)<1); %a mixture distribution with mean 1
for i=1:10
   tic, muhat = meanMC_CLT(Y,0.01,0,0.01,100), toc %try out multiple times with absolute tolerance 0.01
end

%%
% Note that the answers \(\pm\) 0.01 do not overlap.  Thus, some of them
% must be wrong. The problem is that the number of samples used to estimate
% the variance (100) is too small for this distribution with a large
% kurtosis. If we increase the number of samples used to estimate the
% variance to 10000, then the answers are correct.

for i=1:10
   tic, muhat = meanMC_CLT(Y,0.01,0,0.01,10000), toc %try out multiple times with tolerance 0.01
end

%%
% The true mean in this case is 1.
%
% This is great, but how does one know that 10000 samples for estimating
% the variance is enough, but 100 is too few.  We would like a theorem.  If
% we want to have algorithms with solid theoretical justification, then we
% should look at the *Guaranteed Automatic Integration Library (GAIL)*.



