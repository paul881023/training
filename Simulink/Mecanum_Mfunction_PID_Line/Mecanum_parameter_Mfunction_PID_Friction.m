clc;
clear all;
close all;

% motor----- 
%539487 24V 75W
	Ra = 0.38; 
    La = 0.39*10^-3 ;% 0.082mh
    Kt = 28.6*10^-3; % mNm/A
    Kb = Kt; % kb=kt
    Jm = 15.5*10^-7;  %; g-cm^2
    Cm = 0 ;%-----s
    Kf = 0 ;%-----

% Gear Ratio-----
    N_motor = 14;  % 
    N_wheel = 1;
    N = N_motor * N_wheel ;    

    
% Start 
  open_system('Mecanum_Mfunction_PID.slx')
  sim('Mecanum_Mfunction_PID.slx') 
%Result

  % === Position ===
  figure();
  subplot(2,2,1) ;plot(X,Y);title('X-Y');
  subplot(2,2,2) ;plot(t,PHI);title('T-PHI');
  subplot(2,2,3) ;plot(t,X);title('T-X');
  subplot(2,2,4) ;plot(t,Y);title('T-Y')
  
  % === Error ===
  figure();
  subplot(2,2,1) ;plot(X,Y);title('X-Y');
  subplot(2,2,2) ;plot(t,ERR_PHI);title('T-ERR PHI');
  subplot(2,2,3) ;plot(t,ERR_X);title('T-ERR X');
  subplot(2,2,4) ;plot(t,ERR_Y);title('T-ERR Y')
  
  % === Motor Voltage ===
  figure(); 
  subplot(2,2,1); plot(t,U1);title('T-U1')
  subplot(2,2,2); plot(t,U2);title('T-U2')
  subplot(2,2,3); plot(t,U3);title('T-U3')
  subplot(2,2,4); plot(t,U4);title('T-U4')
  
%   figure();
%   subplot(2,2,1) ;plot(t,w1);title('T-w1')
%   subplot(2,2,2) ;plot(t,w2);title('T-w2')
%   subplot(2,2,3) ;plot(t,w3);title('T-w3')
%   subplot(2,2,4) ;plot(t,w4);title('T-w4')
   
  % === Motor torque ===
  figure(); 
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
  
  % === Motor Speed ===
  figure(); 
  subplot(2,2,1) ;plot(t,RPM1);title('T-RPM1')
  subplot(2,2,2) ;plot(t,RPM2);title('T-RPM2')
  subplot(2,2,3) ;plot(t,RPM3);title('T-RPM3')
  subplot(2,2,4) ;plot(t,RPM4);title('T-RPM4')

  % === Cur New model ===
  figure(); 
  subplot(2,2,1); plot(t,Cur1);title('T-Cur1')
  subplot(2,2,2); plot(t,Cur2);title('T-Cur2')
  subplot(2,2,3); plot(t,Cur3);title('T-Cur3')
  subplot(2,2,4); plot(t,Cur4);title('T-Cur4')
  % === Cur old model ===
  figure();
  subplot(2,2,1); plot(t,mTorque1/Kt);title('T- old Cur1')
  subplot(2,2,2); plot(t,mTorque2/Kt);title('T- old Cur2')
  subplot(2,2,3); plot(t,mTorque3/Kt);title('T- old Cur3')
  subplot(2,2,4); plot(t,mTorque4/Kt);title('T- old Cur4')
  

%------ TEST ------%

%   figure(); plot(X_cmd,Y_cmd);title('Xc-Yc');
%   figure(); plot(t,X_cmd);title('T-Xcmd');
%   figure(); plot(t,Y_cmd);title('T-Ycmd');

%   figure(); plot(t,Y_cmd);
%   hold  on  ; plot(t,Y);
% 
%   figure(); plot(t,X);title('T-X');
%   figure(); plot(t,X_dot);title('T-X dot');

figure();
subplot(3,1,1);plot(t,Final_X,'r')  ;hold on ;plot(t,X_cmd,'b')  ;title('X')
subplot(3,1,2);plot(t,Final_Y,'r')  ;hold on ;plot(t,Y_cmd,'b')  ;title('Y') 
subplot(3,1,3);plot(t,Final_phi,'r');hold on ;plot(t,PHI_cmd,'b');title('phi') 

figure();
subplot(3,2,1) ;plot(t,ERR_X);title('T-ERR X');
subplot(3,2,2) ;plot(t,Final_X-X);title('T-ERR of Fin X');
subplot(3,2,3) ;plot(t,ERR_Y);title('T-ERR Y');
subplot(3,2,4) ;plot(t,Final_Y-Y);title('T-ERR of Fin Y')
subplot(3,2,5) ;plot(t,ERR_PHI);title('T-ERR PHI');
subplot(3,2,6) ;plot(t,Final_phi-PHI);title('T-ERR of Fin PHI')


% ==== PPP ===
figure();
set(gcf,'position',[0,300,800,600]);
plot(X_cmd,Y_cmd,'r--','LineWidth',3);hold on;
plot(X,Y,'b-','LineWidth',3);hold on;
grid on;
set(gca,'FontSize',17);
%legend('軌跡命令','模擬響應','FontSize',13,'Fontname','標楷體');
axis([-1,16,-1,9])
axis square;
  
%PHI角響應圖
figure();
plot(t,Final_phi,'r--','LineWidth',3);hold on;
plot(t,PHI,'b-','LineWidth',3);hold on;
%legend('軌跡命令','模擬響應','FontSize',30,'Fontname','標楷體');
axis([0,15,-0.5,0.5]);grid on;
grid on;
set(gca,'FontSize',30);

%===ERR ===
%=== X ===
figure();
set(gcf,'position',[0,0,800,600]);
subplot(8,1,[1,2]);
plot(t,X_cmd - X,'b','LineWidth',3  );set(gca,'FontSize',13);
axis([0,15,-0.01,0.03]);grid on;
%=== Y ===
subplot(8,1,[4,5]);
plot(t,Y_cmd - Y,'b','LineWidth',3  );set(gca,'FontSize',13);
axis([0,15,-0.01,0.03]);grid on;
%=== PHI ===
subplot(8,1,[7,8]);
plot(t,Final_phi - PHI,'b','LineWidth',3  );set(gca,'FontSize',13);
axis([0,15,-0.001,0.001]);grid on;

%========== Voltage =========

figure();
set(gcf,'position',[0,0,800,600]);
subplot(7,1,[1,3]);
plot(t,U1,'b','LineWidth',3  );set(gca,'FontSize',13); grid on;
subplot(7,1,[5,7]);
plot(t,U2,'b','LineWidth',3  );set(gca,'FontSize',13); grid on;

figure()
subplot(7,1,[1,3]);
set(gcf,'position',[0,0,800,600]);
plot(t,U3,'b','LineWidth',3  );set(gca,'FontSize',13); grid on;
subplot(7,1,[5,7]);
plot(t,U4,'b','LineWidth',3  );set(gca,'FontSize',13); grid on;

%=== Torque ===
figure();
set(gcf,'position',[0,0,800,600]);
subplot(7,1,[1,3]);
plot(t,mTorque1,'b','LineWidth',3  );set(gca,'FontSize',13);
axis([0,15,-0.2,2]);grid on;
subplot(7,1,[5,7]);
plot(t,mTorque2,'b','LineWidth',3  );set(gca,'FontSize',13); 
axis([0,15,-0.2,2]);grid on;

figure();
set(gcf,'position',[0,0,800,600]);
subplot(7,1,[1,3]);
plot(t,mTorque3,'b','LineWidth',3  );set(gca,'FontSize',13); grid on;
axis([0,15,-0.2,2]);grid on;
subplot(7,1,[5,7]);
plot(t,mTorque4,'b','LineWidth',3  );set(gca,'FontSize',13); grid on;
axis([0,15,-0.2,2]);grid on;
