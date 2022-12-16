clc;
clear all;
close all;

%set kernels for ZCP(14,12) 
s_1 = [1 1 1 1 1 -1 1 -1 -1 1 1 1 -1 -1 ];
s_2 = [1 -1 1 1 -1 1 -1 -1 -1 1 -1 -1 -1 1 ];

% f_1 = [1 -1 -1 1 -1 1 -1 -1 -1 1];
% f_2 = [1 -1 -1 -1 -1 -1 -1 1 1 -1];

%set kernels for ZCP(26,26) 
f_1 = [1 1 1 -1 -1 1 1 1 -1 1 -1 -1 -1 -1 -1 1 -1 1 1 -1 -1 1 -1 -1 -1 -1];
f_2 = [-1 -1 -1 1 1 -1 -1 -1 1 -1 1 1 -1 1 -1 1 -1 1 1 -1 -1 1 -1 -1 -1 -1];

f_1_PAPR = [1 1 1 0 0 1 1 1 0 1 0 0 0 0 0 1 0 1 1 0 0 1 0 0 0 0];
% s_1 = [1 1 1 1 -1];
% s_2 = [1 -1 1 1 -1];

%get new (364,312)-ZCP
c_1 = kron(s_1,(f_1+f_2)/2);  
c_2 = kron(s_2,(f_1-f_2)/2);
d_1 = kron(s_1,(flip(f_1)-flip(f_2))/2) 
d_2 = kron(s_2,(flip(f_1)+flip(f_2))/2);

F_1 = c_1 + c_2;
F_2 = d_1 - d_2;
ACF_1 = Ac(F_1);
ACF_2 = Ac(F_2);
F_plus = ACF_1 + ACF_2;

stem(F_1);

X = linspace(0,1,10000);
Y = Pc(X,f_1_PAPR)/length(f_1_PAPR);
plot(X,Y);
grid on 
xlabel('t');
[value, max] = max(Y);
disp(value)

AcF = xcorr(f_1);
AcF_bar = xcorr(f_2);
f_plus = AcF + AcF_bar;


function y = Ac(f);
    reg_shift = f;
    y = zeros(1,length(f));
    for k = 1:length(f)
        for i = k:length(f)
            if(reg_shift(i) == f(i))
                y(1,k) = y(1,k) + 1;
            else (reg_shift(i) ~= f(i));
                y(1,k) = y(1,k) - 1;
            end    
        end
        reg_shift = circshift(reg_shift,1);
    end
end

function y = Pc(x,f)
    y = 0;
    f= exp(sqrt(-1)*pi).^f;
    acf = xcorr(f);
    for u=1:length(f)-1
        y = y + real(acf(u+length(f))*exp(sqrt(-1)*2*pi*x*u));
    end
    y = 2*y+length(f); 
end
