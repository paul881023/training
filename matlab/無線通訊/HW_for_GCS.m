clear all
clc
close all
t = 0:0.1:1;
q = 3;
xi = exp(1i*2*pi/q);
f = [1 exp(1i*2*pi/q) exp(1i*4*pi/q)];
f_1 = [1 exp(1i*4*pi/q) exp(1i*2*pi/q)];
f_2 = [1 1 1];

%---------------------------------------%

reg_plus_f_auto = zeros(1,3);
reg_shift = f;

for k = 1:3
    for n = k:3
        reg_plus_f_auto(n)  = reg_shift(n)*f(n);
    end
    sum_f(k) = sum(reg_plus_f_auto);
    reg_shift = circshift(reg_shift,1);
end

%---------------------------------------%

reg_plus_f_auto = zeros(1,3);
reg_shift = f_1;


for k = 1:3
    for n = k:3
        reg_plus_f_auto(n)  = reg_shift(n)*f_1(n);
    end
    sum_f_1(k) = sum(reg_plus_f_auto);
    reg_shift = circshift(reg_shift,1);
end

reg_plus_f_auto = zeros(1,3);
reg_shift = f_2;

%---------------------------------------%

for k = 1:3
    for n = k:3
        reg_plus_f_auto(n)  = reg_shift(n)*f_2(n);
    end
    sum_f_2(k) = sum(reg_plus_f_auto);
    reg_shift = circshift(reg_shift,1);
end

%---------------------------------------%

f_plus =  sum_f + sum_f_1 + sum_f_2;

%---------------------------------------%
tiledlayout(4,1);

nexttile
stem(sum_f,"filled");


nexttile
stem(sum_f_1,"filled");
xlim([0,10]);
ylim([0 20]);

nexttile
stem(sum_f_2,"filled");
xlim([0,10]);
ylim([0 20]);

nexttile
stem(f_plus,"filled");
xlim([0,10]);
ylim([0 20]);