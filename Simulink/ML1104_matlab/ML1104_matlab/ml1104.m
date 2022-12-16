clc;
clear all;

A=[0 1 0;0 0 1;0 0 0];
B=[0;0;1];

C=[0 1 0;0 0 1];
D=[0;0];
fplant=ss(A,B,C,D);
plantDSS=c2d(fplant,0.001);

% Ts=0.1;
% % A = eye(4)+A*Ts;
% % B = B*Ts;
%%離散後
% A=[1 0.1 0.005;0 1 0.1;0 0 1];
% B=[0.0001667;0.005;0.1];

A=[1 1e-03 5e-07;
    0 1 1e-03;
    0 0 1];
B=[5/3*1e-10;
    5e-07;
    1e-03];

C=[0 1 0;0 0 1];
D=[0;0];

Q=[100 0 0 ;
     0 10 0 ;
     0 0 100 ];
 R=1;
 Ts=0.001;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 初始狀態 [E ; error; error_dot]%第一項可能為u
x0 = [0.4;0.49;0.4];% (error )
ref = [0;0;0];
N = 30; %150;
refs = repmat(ref,N,1);

% 保存數據
xs     = []; % beta
thetas = []; % delta
ts     = []; % time
fs     = []; % F

% 初始狀態
x = x0;
t = 0;

% Q矩陣,beta和theta權重要稍微大一點
% % Q = [100 0 0 0
% %      0 10 0 0
% %      0 0 100 0
% %      0 0 0 10];
% % R = 1;
low = -16;
hi = 16;

% simulation的疊代次數
% % % options = optimoptions('fsolve'); 
% % % options.MaxIterations = 1000;%二次規劃的上下邊界
% % % options.MaxFunctionEvaluations = 5000;%同上
for i = 1:10000
    % mpc求解
    %改變邊界
   % options=optimoptions('fsolve','Display','iter','MaxFunctionEvaluations',1000000,'MaxIterations',10000000);
    z = SolveLinearMPC(A, B, x*0, Q, R, low, hi, x, refs, N);
    u = z(1);
    x = A*x+B*u;
    % 保存數據
    fs = [fs, u];
    thetas = [thetas; x(3)];
    xs = [xs, x(1)];
    ts = [ts; t];
    t = t + Ts;
end
% 畫圖
subplot(3,1,1)
plot(ts, thetas);
title('output: error')
grid minor
subplot(3,1,2)
plot(ts, xs);
title('output: error dot')
grid minor
subplot(3,1,3)
plot(ts, fs);
title('input: u')
grid minor
