clc;
close all;
clear all;


%slope axis
syms X(t) Y(t) alpha(t) phi(t)
% syms X_dot(t) Y_dot(t) phi_dot(t)
% syms X_dotdot(t) Y_dotdot(t)  phi_dotdot(t)
syms theta_1(t)  theta_2(t)  theta_3(t)  theta_4(t) theta

syms Lx Ly Lz R mw mb Iyw Izw Izb hw hb g delta

syms tau1 tau2 tau3 tau4

delta = pi/4;


%matrix f

f11 = cos(phi(t) - delta);f41 = cos(phi(t) - delta);
f21 = cos(phi(t) + delta);f31 = cos(phi(t) + delta);
f12 = sin(phi(t) - delta);f42 = sin(phi(t) - delta);
f22 = sin(phi(t) + delta);f32 = sin(phi(t) + delta);
f13 = -(Lx*sin(delta)+Ly*cos(delta));f33 = -(Lx*sin(delta)+Ly*cos(delta));
f23 = (Lx*sin(delta)+Ly*cos(delta));f43 = (Lx*sin(delta)+Ly*cos(delta));
f14 = -R*cos(delta);f25 = -R*cos(delta);f36 = -R*cos(delta);f47 = -R*cos(delta);
f15 = 0;f16 = 0;f17 = 0;f24 = 0;f26 = 0;f27 = 0;f34 = 0;f35 = 0;f37 = 0;f44 = 0;f45 = 0;f46 = 0;

F = [f11 ,f12 ,f13 ,f14 ,f15 ,f16 ,f17
     f21 ,f22 ,f23 ,f24 ,f25 ,f26 ,f27
     f31 ,f32 ,f33 ,f34 ,f35 ,f36 ,f37
     f41 ,f42 ,f43 ,f44, f45 ,f46 ,f47];


h = Y(t) * cos(theta);%alpha

%Lagrandre
T = 1/2*(mb + 4*mw)*(diff(X(t),t)^2 +diff(Y(t),t)^2) + 1/2*Iyw*(diff(theta_1(t),t)^2 + diff(theta_2(t),t)^2 + diff(theta_3(t),t)^2 + diff(theta_4(t),t)^2) ...
    +1/2*(Izb + 4*Izw)*diff(phi(t),t)^2 + 2*mw*(Lx^2 + Ly^2)*diff(phi(t),t)^2;
%V
V = (mb + 4*mw)*g*h;

L = T - V;
%Lagrandre mutiplier
L_x = diff(diff(L,diff(X(t),t)),t) - diff(L,X(t));
L_y = diff(diff(L,diff(Y(t),t)),t) - diff(L,Y(t)); 
L_phi = diff(diff(L,diff(phi(t),t)),t) - diff(L,phi(t)); 

L_theta1 = diff(diff(L,diff(theta_1(t),t)),t) - diff(L,theta_1(t)); 
L_theta2 = diff(diff(L,diff(theta_2(t),t)),t) - diff(L,theta_2(t)); 
L_theta3 = diff(diff(L,diff(theta_3(t),t)),t) - diff(L,theta_3(t)); 
L_theta4 = diff(diff(L,diff(theta_4(t),t)),t) - diff(L,theta_4(t)); 

theta_1_dot_coef = (diff(X(t),t) * cos(phi(t)-delta) + diff(Y(t),t) * sin(phi(t)-delta) ...
                 - diff(phi(t),t)*(Lx*sin(delta) + Ly*cos(delta)))/(R*cos(delta));
theta_2_dot_coef = (diff(X(t),t) * cos(phi(t)+delta) + diff(Y(t),t) * sin(phi(t)+delta) ...
                 + diff(phi(t),t)*(Lx*sin(delta) + Ly*cos(delta)))/(R*cos(delta));
theta_3_dot_coef = (diff(X(t),t) * cos(phi(t)+delta) + diff(Y(t),t) * sin(phi(t)+delta) ...
                 - diff(phi(t),t)*(Lx*sin(delta) + Ly*cos(delta)))/(R*cos(delta));
theta_4_dot_coef = (diff(X(t),t) * cos(phi(t)-delta) + diff(Y(t),t) * sin(phi(t)-delta) ...
                 + diff(phi(t),t)*(Lx*sin(delta) + Ly*cos(delta)))/(R*cos(delta));

theta_1_dotdot_coef = diff(theta_1_dot_coef ,t);
theta_2_dotdot_coef = diff(theta_2_dot_coef ,t);
theta_3_dotdot_coef = diff(theta_3_dot_coef ,t);
theta_4_dotdot_coef = diff(theta_4_dot_coef ,t);

landa_1 = (tau1 - Iyw*theta_1_dotdot_coef)/(R*cos(delta));
landa_2 = (tau2 - Iyw*theta_2_dotdot_coef)/(R*cos(delta));
landa_3 = (tau3 - Iyw*theta_3_dotdot_coef)/(R*cos(delta));
landa_4 = (tau4 - Iyw*theta_4_dotdot_coef)/(R*cos(delta));

X_dotdot_coef = landa_1 * f11 + landa_2 * f21 + landa_3 * f31 + landa_4 * f41;
Y_dotdot_coef = landa_1 * f12 + landa_2 * f22 + landa_3 * f32 + landa_4 * f42;
PHI_dotdot_coef = landa_1 * f13 + landa_2 * f23 + landa_3 * f33 + landa_4 * f43;


Final_x = X_dotdot_coef / L_x;
Final_y = Y_dotdot_coef / L_y;
Final_phi = PHI_dotdot_coef / L_phi;

%g h i 
g = X_dotdot_coef - L_x;
g1 = diff(g,diff(diff(X(t),t),t));
g2 = diff(g,diff(diff(Y(t),t),t));
g3 = diff(g,diff(diff(phi(t),t),t));
c1 = g - g1*diff(diff(X(t),t),t)-g2*diff(diff(Y(t),t),t)-g3*diff(diff(phi(t),t),t);

h = Y_dotdot_coef - L_y;
h1 = diff(h,diff(diff(X(t),t),t));
h2 = diff(h,diff(diff(Y(t),t),t));
h3 = diff(h,diff(diff(phi(t),t),t));
c2 = h - h1*diff(diff(X(t),t),t)-h2*diff(diff(Y(t),t),t)-h3*diff(diff(phi(t),t),t);

i = PHI_dotdot_coef - L_phi;
i1 = diff(i,diff(diff(X(t),t),t));
i2 = diff(i,diff(diff(Y(t),t),t));
i3 = diff(i,diff(diff(phi(t),t),t));
c3 = i - i1*diff(diff(X(t),t),t)-i2*diff(diff(Y(t),t),t)-i3*diff(diff(phi(t),t),t);
%解聯立

D = [g1,g2,g3
     h1,h2,h3
     i1,i2,i3];
C = [c1
     c2
     c3];
D_inv = inv(D);
D_final = simplify(-D_inv*C);

