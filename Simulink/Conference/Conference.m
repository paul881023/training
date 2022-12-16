


t = Data_PID(1:20000);
Xcmd = Data_PID(40001:60000);
Ycmd = Data_PID(60001:80000);
PHIcmd = Data_PID(100001:120000);

PID_X   = Data_PID(40001:60000);
PID_Y   = Data_PID(80001:100000);
PID_PHI =  (120001:140000);

SM_X   = Data_SM(40001:60000);
SM_Y   = Data_SM(80001:100000);
SM_PHI = Data_SM(120001:140000);

% ===== X-Y =====
figure();
set(gcf,'position',[0,300,800,600]);
plot(Xcmd,Ycmd,'r--','LineWidth',3);hold on;
plot(PID_X,PID_Y,'b-','LineWidth',3);hold on;
plot(SM_X,SM_Y,'g-','LineWidth',3);hold on;
plot(0,-0.8,'*');
axis([-1,1,-1.8,0.2])
grid on;
set(gca,'FontSize',17);
%legend('軌跡命令','模擬響應','FontSize',13,'Fontname','標楷體');
axis square;

% ===== Error =====
figure();
set(gcf,'position',[0,0,800,600]);
subplot(8,1,[1,2]);
plot(t,Xcmd-PID_X,'b','LineWidth',3  ); hold on;
plot(t,Xcmd-SM_X,'r','LineWidth',3  );
set(gca,'FontSize',13);
axis([0,20,-0.01,0.01]);grid on;
%=== Y ===
subplot(8,1,[4,5]);
plot(t,Ycmd-PID_Y,'b','LineWidth',3  );hold on;
plot(t,Ycmd-SM_Y,'r','LineWidth',3  );
;set(gca,'FontSize',13);
axis([0,20,-0.01,0.01]);grid on;
%=== PHI ===
subplot(8,1,[7,8]);
plot(t,PHIcmd-PID_PHI,'b','LineWidth',3  ); hold on;
plot(t,PHIcmd-SM_PHI,'r','LineWidth',3  ); hold on;
set(gca,'FontSize',13);
axis([0,20,-0.001,0.001]);grid on;