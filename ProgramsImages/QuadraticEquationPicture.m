%Picture of a quadratic equation
%% Garbage collection and initialization
format compact %remove blank lines from output
format long e %lots of digits
clear all %clear all variables
close all %close all figures
set(0,'defaultaxesfontsize',30,'defaulttextfontsize',30) %make font larger
set(0,'defaultLineLineWidth',3) %thick lines
set(0,'defaultTextInterpreter','latex') %latex axis labels
set(0,'defaultLineMarkerSize',40) %larger markers

%% Define the quadratic equation and find its roots
a=1;
b=-3;
c=2;
xroot=qeq(a,b,c);

%% Plot the picture
xplot=-3*b/(2*a)+(0:0.002:1)*(2*b/a);
xmin=min(xplot);
xmax=max(xplot);
yplot=c+xplot.*(b+xplot*a);
plot(xplot,yplot,'b-',[xmin xmax],[0 0],'k-')
hold on
if isreal(xroot(1))
   plot(xroot,[0 0],'r.')
end
axis([xmin xmax min(yplot) max(yplot)])
xlabel('$x$')
ylabel('$a x^2 + bx+ c$')
title(['$a=' num2str(a) ', b=' num2str(b) ', c=' num2str(c) '$'])
print -depsc quadraticequationplot.eps
