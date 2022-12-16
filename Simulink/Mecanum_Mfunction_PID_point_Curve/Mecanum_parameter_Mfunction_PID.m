clc;
clear all;
close all;

% motor----- 
%539487 24V 75W
	Ra = 0.38; 
    La = 0.39*10^-3 ;% 0.082mh
    Kt = 136;   %28.6*10^-3; % mNm/A
    Kb = Kt; % kb=kt
    Jm = 15.5*10^-7;  %; g-cm^2
    Cm = 0 ;%-----s
    Kf = 0 ;%-----

% Gear Ratio-----
    N_motor = 32;   % 14;  % 
    N_wheel = 1;
    N = N_motor * N_wheel ;    

    
% Start 
  open_system('Mecanum_Mfunction_PID.slx')
  sim('Mecanum_Mfunction_PID.slx')

  555
  
%Result
 
  figure(1); 
  subplot(2,2,1); plot(t,U1);title('左前馬達電流'); xlabel('(sec)'); ylabel('(A)'); grid on
  subplot(2,2,2); plot(t,U2);title('右前馬達電流'); xlabel('(sec)'); ylabel('(A)'); grid on
  subplot(2,2,3); plot(t,U3);title('左後馬達電流'); xlabel('(sec)'); ylabel('(A)'); grid on
  subplot(2,2,4); plot(t,U4);title('右後馬達電流'); xlabel('(sec)'); ylabel('(A)'); grid on  
  figure(2); 
  subplot(2,2,1) ;plot(t,mTorque1);title('T-mTorque1')
  subplot(2,2,2) ;plot(t,mTorque2);title('T-mTorque2')
  subplot(2,2,3) ;plot(t,mTorque3);title('T-mTorque3')
  subplot(2,2,4) ;plot(t,mTorque4);title('T-mTorque4')
  
  MT1 = max(abs(mTorque1));
  MT2 = max(abs(mTorque2));
  MT3 = max(abs(mTorque3));
  MT4 = max(abs(mTorque4));
  
  
  RPM1 = w1/2/pi*60;
  RPM2 = w2/2/pi*60;
  RPM3 = w3/2/pi*60;
  RPM4 = w4/2/pi*60;
  
  MRPM1 = max(abs(RPM1));
  MRPM2 = max(abs(RPM2));
  MRPM3 = max(abs(RPM3));
  MRPM4 = max(abs(RPM4));
  
  
  figure(3); 
  subplot(2,2,1) ;plot(t,RPM1);title('T-RPM1')
  subplot(2,2,2) ;plot(t,RPM2);title('T-RPM2')
  subplot(2,2,3) ;plot(t,RPM3);title('T-RPM3')
  subplot(2,2,4) ;plot(t,RPM4);title('T-RPM4')
  
figure(4);
subplot(3,1,1);plot(t,Final_X,'r')  ;hold on ;plot(t,X_cmd,'b')  ;title('X')
subplot(3,1,2);plot(t,Final_Y,'r')  ;hold on ;plot(t,Y_cmd,'b')  ;title('Y') 
subplot(3,1,3);plot(t,Final_phi,'r');hold on ;plot(t,PHI_cmd,'b');title('phi') 

figure(5);
subplot(3,1,1) ;plot(t, ERR_X, 'LineWidth', 3);title('T-ERR X'); ylabel('error(m)'); xlabel('t(sec)'); grid on
% subplot(3,2,2) ;plot(t,Final_X-X);title('T-ERR of Fin X');
subplot(3,1,2) ;plot(t, ERR_Y, 'LineWidth', 3);title('T-ERR Y'); ylabel('error(m)'); xlabel('t(sec)'); grid on
% subplot(3,2,4) ;plot(t,Final_Y-Y);title('T-ERR of Fin Y')
subplot(3,1,3) ;plot(t, ERR_PHI, 'LineWidth',3);title('T-ERR PHI'); ylabel('error(degree)'); xlabel('t(sec)'); grid on
% subplot(3,2,6) ;plot(t,Final_phi-PHI);title('T-ERR of Fin PHI')

% PPPPPPPPPPP
% % X-Y
% figure();
% plot(X,Y);hold on;
% plot(0,0,'*');hold on;
% plot(0.5,0.3,'*');
% % set(gca,'XTick',[-0.1:0.1:0.6])
% % set(gca,'YTick',[-0.1:0.1:0.6])
% % axis([-0.1,0.6,-0.1,0.4])
% grid on;
% set(gca,'FontSize',30);
% 
% %X軸
% figure();
% plot(t,Final_X,'-.');hold on;
% plot(t,X);
% % set(gca,'XTick',[0:0.5:6])
% % set(gca,'YTick',[0:0.1:0.6])
% % axis([0,6,0,0.6])
% legend('命令軌跡','模擬軌跡','FontSize',30,'Fontname','標楷體');
% set(gca,'FontSize',30);
% grid on;
% 
% %Y軸
% figure();
% plot(t,Final_Y,'-.');hold on;
% plot(t,Y);
% % set(gca,'XTick',[0:0.5:6])
% % set(gca,'YTick',[0:0.1:0.4])
% % axis([0,6,0,0.4])
% legend('命令軌跡','模擬軌跡','FontSize',30,'Fontname','標楷體');
% set(gca,'FontSize',30);
% grid on;
% 
% %PHI軸
% figure();
% plot(t,Final_phi,'-.');hold on;
% plot(t,PHI);
% % set(gca,'XTick',[0:0.5:6])
% % set(gca,'YTick',[0:0.2:1])
% % axis([0,6,0,1])
% legend('命令軌跡','模擬軌跡','FontSize',30,'Fontname','標楷體');
% set(gca,'FontSize',30);
% grid on;  
% 
% %X軸誤差
% figure();
% plot(t,Final_X-X);hold on;
% % set(gca,'XTick',[0:0.5:6])
% % set(gca,'YTick',[-0.1:0.1:0.6])
% % axis([0,6,-0.1,0.6])
% set(gca,'FontSize',30);
% grid on;
% 
% %Y軸誤差
% figure();
% plot(t,Final_Y-Y);hold on;
% % set(gca,'XTick',[0:0.5:6])
% % set(gca,'YTick',[-0.1:0.1:0.4])
% % axis([0,6,-0.1,0.4])
% set(gca,'FontSize',30);
% grid on;
% 
% %PHI軸誤差
% figure();
% plot(t,Final_phi-PHI);hold on;
% % set(gca,'XTick',[0:0.5:6])
% % set(gca,'YTick',[-0.2:0.2:1])
% % axis([0,6,-0.2,1])
% set(gca,'FontSize',30);
% grid on;
% 
% %馬達電壓1
% figure();
% plot(t,U1)
% % set(gca,'XTick',[0:0.5:6])
% % set(gca,'YTick',[-4:2:4])
% % axis([0,6,-5,5])
% set(gca,'FontSize',30);
% grid on;
% 
% %馬達電壓2
% figure();
% plot(t,U2)
% % set(gca,'XTick',[0:0.5:6])
% % set(gca,'YTick',[-2:2:12])
% % axis([0,6,-2,12])
% set(gca,'FontSize',30);
% grid on;
% 
% %馬達電壓3
% figure();
% plot(t,U3)
% % set(gca,'XTick',[0:0.5:6])
% % set(gca,'YTick',[-4:2:10])
% % axis([0,6,-4,10])
% set(gca,'FontSize',30);
% grid on;
% 
% %馬達電壓4
% figure();
% plot(t,U4)
% % set(gca,'XTick',[0:2:6])
% % set(gca,'YTick',[-4:2:8])
% % axis([0,6,-2,8])
% set(gca,'FontSize',30);
% grid on;
% 
% figure();
% subplot(2,1,1);plot(t,U1);
% subplot(2,1,2);plot(t,U2);
% figure();
% subplot(2,1,1);plot(t,U3);
% subplot(2,1,2);plot(t,U4);

% Circle
Theta_1 = linspace(0, 2*pi, 100);
r1 = 1;
Xc1 = 6 + r1*cos(Theta_1);
Yc1 = -1.5 + r1*sin(Theta_1);

Theta_2 = linspace(0, 2*pi, 100);
r1 = 1;
Xc2 = 2 + r1*cos(Theta_2);
Yc2 = -1.5 + r1*sin(Theta_2);

% % PPPPPPPPPPP
% X-Y
figure();
set(gcf,'position',[0,300,800,600]);
plot(X_cmd(1:20000),Y_cmd(1:20000),'*','LineWidth',3);hold on;
plot(X(1:20000),Y(1:20000),'r-','LineWidth',3);hold on;
plot(Xc1, Yc1, 'g-'); hold on;
plot(Xc2, Yc2, 'm-'); hold on;
title('X-Y position (m)');
axis([0,10,-3.5,1.0])
grid on;
set(gca,'FontSize',17);
legend('Command', 'Real', 'Fontsize', 13, 'Fontname', '標楷體');
%legend('軌跡命令','模擬響應','FontSize',13,'Fontname','標楷體');
axis square;

%===ERR ===
%=== X ===
figure();
set(gcf,'position',[0,0,800,600]);
subplot(8,1,[1,2]);
plot(t(1:20000),X_cmd(1:20000) - X(1:20000),'b','LineWidth',3  );set(gca,'FontSize',13);
axis([0,20,-0.01,0.01]);grid on;
%=== Y ===
subplot(8,1,[4,5]);
plot(t(1:20000),Y_cmd(1:20000) - Y(1:20000),'b','LineWidth',3  );set(gca,'FontSize',13);
axis([0,20,-0.01,0.01]);grid on;
%=== PHI ===
subplot(8,1,[7,8]);
plot(t(1:20000),0 - PHI(1:20000),'b','LineWidth',3  );set(gca,'FontSize',13);
axis([0,20,-0.001,0.001]);grid on;
