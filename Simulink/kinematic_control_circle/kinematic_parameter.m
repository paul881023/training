clc;clear all;

% Controller 
kp = 150;  %2     %15
ki = 0.1;  %1   %0.01
kd = 200;  %5     %10
%{
  PID=[ 80 0.1 80]
%}

% Motor Controller 
Kp_m = 0.5;  %2     %15
Ki_m = 3;  %1   %0.01

Kp_pos = 3;
Ki_pos = 5;

% Kp_pos = 20;
% Ki_pos = 15;

Kp_deg = 2;
Ki_deg = 3;


% motor----- 
%539487 24V 75W
	Ra = 0.38; 
    La = 0.39*10^-3 ;% 0.082mh
    Kt = 28.6*10^-3; % mNm/A
    Kb = Kt; % kb=kt
    Jm = 0;%15.5*10^-7;  %; g-cm^2
    Cm = 0 ;%-----s
    Kf = 0 ;%-----

% Gear Ratio-----
    N_motor = 14;  % 
    N_wheel = 1;
    N = N_motor * N_wheel ;    

    
% body
mb = 320;   %30;
 d = 0.6;
 w = 0.4;
Izb = 1/12*(d^2+w^2);

% wheel
R = 0.05; % Wheel
mw = 0.4;
lx = 0.2375 ;% 
ly = 0.2394; % 
Iyw = mw*R^2/2;
Izw = mw*(lx^2+ly^2);

% wheel
Friction = 0;
%Friction = (mb+4*mw)/4*9.8*0.002;
% Start 
  open_system('kinematic_control.slx')
  sim('kinematic_control.slx')

  
%Result

  figure(); % ERR_POS
  subplot(2,2,1) ;plot(X,Y);title('X-Y');
  subplot(2,2,2) ;plot(t,ERR_PHI);title('T-ERR PHI');
  subplot(2,2,3) ;plot(t,ERR_X);title('T-ERR X');
  subplot(2,2,4) ;plot(t,ERR_Y);title('T-ERR Y')
  
  figure(); % U 
  subplot(2,2,1) ;plot(t,U1);title('T-U1')
  subplot(2,2,2) ;plot(t,U2);title('T-U2')
  subplot(2,2,3) ;plot(t,U3);title('T-U3')
  subplot(2,2,4) ;plot(t,U4);title('T-U4')
%   
%   figure(); plot(t,w1);title('T-w1')
%   figure(); plot(t,w2);title('T-w2')
%   figure(); plot(t,w3);title('T-w3')
%   figure(); plot(t,w4);title('T-w4')

%   figure(); plot(t,ERR_w1);title('T-ERR_w1')
%   figure(); plot(t,ERR_w2);title('T-ERR_w2')
%   figure(); plot(t,ERR_w3);title('T-ERR_w3')
%   figure(); plot(t,ERR_w4);title('T-ERR_w4')
%    
  figure();
  subplot(2,2,1) ;plot(t,mTorque1);title('T-mTorque1')
  subplot(2,2,2) ;plot(t,mTorque2);title('T-mTorque2')
  subplot(2,2,3) ;plot(t,mTorque3);title('T-mTorque3')
  subplot(2,2,4) ;plot(t,mTorque4);title('T-mTorque4')
% %    
%   
%   MT1 = max(abs(mTorque1))
%   MT2 = max(abs(mTorque2))
%   MT3 = max(abs(mTorque3))
%   MT4 = max(abs(mTorque4))
%   
%   
  RPM1 = w1/2/pi*60;
  RPM2 = w2/2/pi*60;
  RPM3 = w3/2/pi*60;
  RPM4 = w4/2/pi*60;
%   
%   MRPM1 = max(abs(RPM1))
%   MRPM2 = max(abs(RPM2))
%   MRPM3 = max(abs(RPM3))
%   MRPM4 = max(abs(RPM4))

  figure();
  subplot(2,2,1) ;plot(t,RPM1);title('T-RPM1')
  subplot(2,2,2) ;plot(t,RPM2);title('T-RPM2')
  subplot(2,2,3) ;plot(t,RPM3);title('T-RPM3')
  subplot(2,2,4) ;plot(t,RPM4);title('T-RPM4')
  
%   figure(); plot(t,Cur1);title('T-Cur1')
%   figure(); plot(t,Cur2);title('T-Cur2')
%   figure(); plot(t,Cur3);title('T-Cur3')
%   figure(); plot(t,Cur4);title('T-Cur4')

%------ TEST ------%
% 
%   figure(); plot(X_cmd,Y_cmd);title('Xc-Yc');
%   figure(); plot(t,X_cmd);title('T-Xcmd');
%   figure(); plot(t,Y_cmd);title('T-Ycmd');

  figure(); plot(t,X_dot);title('T-X dot');
%   figure(); plot(t,X_dot);title('T-Y dot');
%   figure(); plot(t,X_cmd,'r');
%   hold  on  ; plot(t,X,'b');
% 
%   figure(); plot(t,Y_cmd);
%   hold  on  ; plot(t,Y);
% 
%   figure(); plot(t,X);title('T-X');
%   figure(); plot(t,X_dot);title('T-X dot');% % PPPPPPPPPPP









% % PPPPPPPPPPP
% X-Y
figure();
set(gcf,'position',[0,300,800,600]);
plot(X_cmd(1:20000),Y_cmd(1:20000),'r--','LineWidth',3);hold on;
plot(X(1:20000),Y(1:20000),'b-','LineWidth',3);hold on;
plot(0,-0.8,'*');
axis([-1,1,-1.8,0.2])
grid on;
set(gca,'FontSize',17);
%legend('­y¸ñ©R¥O','¼ÒÀÀÅTÀ³','FontSize',13,'Fontname','¼Ð·¢Åé');
axis square;
% 

%PHI¨¤ÅTÀ³¹Ï
figure();
plot(t(1:20000),Final_phi(1:20000),'r--','LineWidth',3);hold on;
plot(t(1:20000),PHI(1:20000),'b-','LineWidth',3);hold on;
axis([0,20,-0.5,0.5]);grid on;
%legend('­y¸ñ©R¥O','¼ÒÀÀÅTÀ³','FontSize',30,'Fontname','¼Ð·¢Åé');
grid on;
set(gca,'FontSize',30);

%===ERR ===
%=== X ===
figure();
set(gcf,'position',[0,0,800,600]);
subplot(8,1,[1,2]);
plot(t(1:20000),X_cmd(1:20000) - X(1:20000),'b','LineWidth',3  );set(gca,'FontSize',13);
axis([0,20,-0.15,0.15]);grid on;
%=== Y ===
subplot(8,1,[4,5]);
plot(t(1:20000),Y_cmd(1:20000) - Y(1:20000),'b','LineWidth',3  );set(gca,'FontSize',13);
axis([0,20,-0.1,0.1]);grid on;
%=== PHI ===
subplot(8,1,[7,8]);
plot(t(1:20000),Final_phi(1:20000) - PHI(1:20000),'b','LineWidth',3  );set(gca,'FontSize',13);
axis([0,20,-0.001,0.001]);grid on;

%========== Voltage =========

figure();
set(gcf,'position',[0,0,800,600]);
subplot(7,1,[1,3]);
plot(t(1:20000),U1(1:20000),'b','LineWidth',3  );set(gca,'FontSize',13); grid on;
axis([0,20,-8,8]);grid on;

subplot(7,1,[5,7]);
plot(t(1:20000),U2(1:20000),'b','LineWidth',3  );set(gca,'FontSize',13); grid on;
axis([0,20,-8,8]);grid on;

figure()
subplot(7,1,[1,3]);
set(gcf,'position',[0,0,800,600]);
plot(t(1:20000),U3(1:20000),'b','LineWidth',3  );set(gca,'FontSize',13); grid on;
axis([0,20,-8,8]);grid on;
subplot(7,1,[5,7]);
plot(t(1:20000),U4(1:20000),'b','LineWidth',3  );set(gca,'FontSize',13); grid on;
axis([0,20,-8,8]);grid on;