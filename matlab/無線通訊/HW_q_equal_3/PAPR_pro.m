tic
clear;
clc;
close all
f  = [0 0 0 1 0 0 1 0 0 0 0 1 1 1 0 1];
X = linspace(0,1,10000);
Y = Pc(X,f)/length(f);
plot(X,Y);
grid on 
xlabel('t');
[argvalue, argmax] = max(Y);
disp(argvalue)
toc
function y = Pc(x,f)
    y = 0;
    f= exp(sqrt(-1)*pi).^f;
    acf = xcorr(f);
    for u=1:length(f)-1
        y = y + real(acf(u+16)*exp(sqrt(-1)*2*pi*x*u));
    end
    y = 2*y+length(f); 
end
