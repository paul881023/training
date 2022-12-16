clc;
clear all;
close all;

syms X(t) Y(t) phi(t) 
syms W_L(t) W_R(t) 
syms R L I_yw m_b m_w I_zb I_zw L_x L_y d
syms tau_R tau_L
%
X_dot(t) = (diff(W_R(t),t)+diff(W_L(t),t))*R*sin(phi(t))/2;
Y_dot(t) = (diff(W_R(t),t)+diff(W_L(t),t))*R*cos(phi(t))/2;
phi_dot(t) = (diff(W_R(t),t)+diff(W_L(t),t))*R/L;

X_dotdot_coef2 = (diff(X_dot(t),t));
Y_dotdot_coef2 = (diff(Y_dot(t),t));
phi_dotdot_coef2 = (diff(phi_dot(t),t));

%d = 0;

M = [R/2*sin(phi(t)) ,R/2*sin(phi(t)),
     R/2*cos(phi(t)) ,R/2*cos(phi(t)),
     R/L            ,-R/L];
M_inv = simplify(inv(M.'*M)*M.');

W_R_dot_coef = M_inv(1,1)*diff(X(t),t) + M_inv(1,2)*diff(Y(t),t) + M_inv(1,3)*diff(phi(t),t); 
W_L_dot_coef = M_inv(2,1)*diff(X(t),t) + M_inv(2,2)*diff(Y(t),t) + M_inv(2,3)*diff(phi(t),t); 
%
Xc_dot_2 = diff(X(t) + d*cos(phi(t)),t)^2;
Yc_dot_2 = diff(Y(t) + d*sin(phi(t)),t)^2;

X_wR_dot_2 = diff(X(t) + L*sin(phi(t)),t)^2;
Y_wR_dot_2 = diff(Y(t) + L*cos(phi(t)),t)^2;

X_wL_dot_2 = diff(X(t) - L*sin(phi(t)),t)^2;
Y_wL_dot_2 = diff(Y(t) - L*cos(phi(t)),t)^2;

V_c = Xc_dot_2 + Yc_dot_2;
V_wR = X_wR_dot_2 + Y_wR_dot_2;
V_wL = X_wL_dot_2 + Y_wL_dot_2;

%
T_2 = 1/2*(2*m_w+m_b)*(X_dot^2 + Y_dot^2) + 1/2*(2*I_zw+I_zb)*phi_dot^2 + 1/2*(I_yw)*((diff(W_R(t),t))^2 + (diff(W_L(t),t))^2)+m_w*((L/2)^2+d^2)*(diff(phi(t),t));
W_R_dot_coef2 = diff(diff(T_2,diff(W_R(t),t)),t) - diff(T_2,W_R(t));
W_L_dot_coef2 = diff(diff(T_2,diff(W_L(t),t)),t) - diff(T_2,W_L(t));
D_final3 = simplify([W_R_dot_coef2,
            W_L_dot_coef2]);

%
T = 1/2*(2*m_w+m_b)*(diff(X(t),t)^2 + diff(Y(t),t)^2) + 1/2*(2*I_zw+I_zb)*diff(phi(t),t)^2 + 1/2*(I_yw)*(diff(W_R(t),t)^2+diff(W_L(t),t)^2)+m_w*((L/2)^2+d^2)*diff(phi(t),t)^2;
% T = 1/2*m_b*V_c + 1/2 * I_yw * diff(phi(t),t)^2 + 1/2*m_w*(V_wR + V_wL) + I_zb*diff(phi(t),t)^2 + 1/2*I_zw*(W_L(t) + W_R(t));
T_x = diff(diff(T,diff(X(t),t)),t) - diff(T,X(t));
T_y = diff(diff(T,diff(Y(t),t)),t) - diff(T,Y(t));
T_phi = diff(diff(T,diff(phi(t),t)),t) - diff(phi,X(t));

T_WR = diff(diff(T,diff(W_R(t),t)),t) - diff(W_R,X(t));
T_LR = diff(diff(T,diff(W_L(t),t)),t) - diff(W_L,X(t));
%
f11 = sin(phi(t))/R; f12 = sin(phi(t))/R;
f21 = cos(phi(t))/R; f22 = cos(phi(t))/R;
f31 = L/(2*R); f32 = -L/(2*R);
f41 = -1; f42 = 0;
f51 = 0; f52 = -1;

W_R_dotdot_coef = diff(W_R_dot_coef,t);
W_L_dotdot_coef = diff(W_L_dot_coef,t);

landa_1 = tau_R - I_yw*W_R_dotdot_coef;
landa_2 = tau_L - I_yw*W_L_dotdot_coef;

X_dotdot_coef = simplify(landa_1 * f11 + landa_2 * f12);
Y_dotdot_coef = simplify(landa_1 * f21 + landa_2 * f22);
phi_dotdot_coef = simplify(landa_1 * f31 + landa_2 * f32);

g = X_dotdot_coef - T_x;
g1 = diff(g,diff(diff(X(t),t),t));
g2 = diff(g,diff(diff(Y(t),t),t));
g3 = diff(g,diff(diff(phi(t),t),t));
c1 = g - g1*diff(diff(X(t),t),t)-g2*diff(diff(Y(t),t),t)-g3*diff(diff(phi(t),t),t);

h = Y_dotdot_coef - T_y;
h1 = diff(h,diff(diff(X(t),t),t));
h2 = diff(h,diff(diff(Y(t),t),t));
h3 = diff(h,diff(diff(phi(t),t),t));
c2 = h - h1*diff(diff(X(t),t),t)-h2*diff(diff(Y(t),t),t)-h3*diff(diff(phi(t),t),t);

i = phi_dotdot_coef - T_phi;
i1 = diff(i,diff(diff(X(t),t),t));
i2 = diff(i,diff(diff(Y(t),t),t));
i3 = diff(i,diff(diff(phi(t),t),t));
c3 = i - i1*diff(diff(X(t),t),t)-i2*diff(diff(Y(t),t),t)-i3*diff(diff(phi(t),t),t);

D = [g1,g2,g3
     h1,h2,h3
     i1,i2,i3];
C = [c1
     c2
     c3];
D_inv = inv(D);
D_final = simplify(-D_inv*C);

X_dotdot = simplify((2*I_yw*Y_dot*phi_dot + R*tau_L*sin(phi(t)) + R*tau_R*sin(phi(t)) - 2*I_yw*cos(phi(t))^2*Y_dot*phi_dot - 2*I_yw*cos(phi(t))*sin(phi(t))*X_dot*phi_dot)/(2*I_yw + R^2*m_b + 2*R^2*m_w));
Y_dotdot = simplify((cos(phi(t))*(R*tau_L + R*tau_R - 2*I_yw*cos(phi(t))*X_dot*phi_dot + 2*I_yw*sin(phi(t))*Y_dot*phi_dot))/(2*I_yw + R^2*m_b + 2*R^2*m_w));
phi_dotdot = simplify((-(L*R*(tau_L - tau_R))/(I_yw*L^2 + 2*I_zb*R^2 + 4*I_zw*R^2 + L^2*R^2*m_w)));

X_dotdot2 = (R^4*d^2*m_b^3*Y_dot*phi_dot + 8*L^2*R^3*m_w^2*tau_L*sin(phi(t)) + 8*L^2*R^3*m_w^2*tau_R*sin(phi(t)) + R^3*d^2*m_b^2*tau_L*sin(phi(t)) + R^3*d^2*m_b^2*tau_R*sin(phi(t)) + I_yw^2*L^2*m_b*Y_dot*phi_dot + 2*I_yw^2*L^2*m_w*Y_dot*phi_dot + 2*I_yw^2*R^2*m_b*Y_dot*phi_dot + 4*I_yw^2*R^2*m_w*Y_dot*phi_dot + 2*I_yw*R^3*m_b*tau_L*sin(phi(t)) + 2*I_yw*R^3*m_b*tau_R*sin(phi(t)) + 4*I_zb*R^3*m_b*tau_L*sin(phi(t)) + 4*I_zb*R^3*m_b*tau_R*sin(phi(t)) + 4*I_yw*R^3*m_w*tau_L*sin(phi(t)) + 4*I_yw*R^3*m_w*tau_R*sin(phi(t)) + 8*I_zb*R^3*m_w*tau_L*sin(phi(t)) + 8*I_zb*R^3*m_w*tau_R*sin(phi(t)) - R^3*d^2*m_b^2*tau_L*sin(3*phi(t)) - R^3*d^2*m_b^2*tau_R*sin(3*phi(t)) - I_yw^2*L^2*m_b*cos(2*phi(t))*Y_dot*phi_dot - 2*I_yw^2*L^2*m_w*cos(2*phi(t))*Y_dot*phi_dot - 2*I_yw^2*R^2*m_b*cos(2*phi(t))*Y_dot*phi_dot - 4*I_yw^2*R^2*m_w*cos(2*phi(t))*Y_dot*phi_dot + 8*I_yw*L^2*R^2*m_w^2*Y_dot*phi_dot - I_yw^2*L^2*m_b*sin(2*phi(t))*X_dot*phi_dot - 2*I_yw^2*L^2*m_w*sin(2*phi(t))*X_dot*phi_dot - 2*I_yw^2*R^2*m_b*sin(2*phi(t))*X_dot*phi_dot - 4*I_yw^2*R^2*m_w*sin(2*phi(t))*X_dot*phi_dot + I_yw^2*L^2*d*m_b*cos(3*phi(t))*phi_dot^2 + 2*I_yw*R^2*d^2*m_b^2*Y_dot*phi_dot + 2*I_yw^2*R^2*d*m_b*cos(3*phi(t))*phi_dot^2 + 2*I_yw*R^2*d^3*m_b^2*cos(phi(t))*phi_dot^2 - L*R^3*d*m_b^2*tau_L*sin(phi(t)) + L*R^3*d*m_b^2*tau_R*sin(phi(t)) + 4*L^2*R^3*m_b*m_w*tau_L*sin(phi(t)) + 4*L^2*R^3*m_b*m_w*tau_R*sin(phi(t)) + 2*R^4*d^2*m_b^2*m_w*Y_dot*phi_dot + 4*R^4*d^3*m_b^2*m_w*cos(phi(t))*phi_dot^2 + 4*I_yw*I_zb*R^2*m_b*Y_dot*phi_dot + 8*I_yw*I_zb*R^2*m_w*Y_dot*phi_dot + 4*R^3*d^2*m_b*m_w*tau_L*sin(phi(t)) + 4*R^3*d^2*m_b*m_w*tau_R*sin(phi(t)) - R^4*d^2*m_b^3*cos(2*phi(t))*Y_dot*phi_dot + 2*I_yw*R^2*d^3*m_b^2*cos(3*phi(t))*phi_dot^2 + R^4*d^2*m_b^3*sin(2*phi(t))*X_dot*phi_dot + I_yw*L^2*R*m_b*tau_L*sin(phi(t)) + I_yw*L^2*R*m_b*tau_R*sin(phi(t)) + 2*I_yw*L^2*R*m_w*tau_L*sin(phi(t)) + 2*I_yw*L^2*R*m_w*tau_R*sin(phi(t)) + I_yw^2*L^2*d*m_b*cos(phi(t))*phi_dot^2 + 2*I_yw^2*R^2*d*m_b*cos(phi(t))*phi_dot^2 + 2*I_yw*R^4*d*m_b^2*cos(phi(t))*phi_dot^2 + 4*I_zb*R^4*d*m_b^2*cos(phi(t))*phi_dot^2 + 2*I_yw*R^2*d^2*m_b^2*sin(2*phi(t))*X_dot*phi_dot + 2*I_yw*R^2*d^2*m_b^2*sin(4*phi(t))*X_dot*phi_dot - 2*R^4*d^2*m_b^2*m_w*cos(2*phi(t))*Y_dot*phi_dot - 4*I_yw*I_zb*R^2*m_b*cos(2*phi(t))*Y_dot*phi_dot - 8*I_yw*I_zb*R^2*m_w*cos(2*phi(t))*Y_dot*phi_dot + 2*R^4*d^2*m_b^2*m_w*sin(2*phi(t))*X_dot*phi_dot - 4*I_yw*I_zb*R^2*m_b*sin(2*phi(t))*X_dot*phi_dot - 8*I_yw*I_zb*R^2*m_w*sin(2*phi(t))*X_dot*phi_dot + 4*I_yw*I_zb*R^2*d*m_b*cos(3*phi(t))*phi_dot^2 + 4*I_yw*L^2*R^2*m_b*m_w*Y_dot*phi_dot - I_yw*L*R*d*m_b*tau_L*sin(3*phi(t)) + I_yw*L*R*d*m_b*tau_R*sin(3*phi(t)) + 4*I_yw*R^2*d^2*m_b*m_w*Y_dot*phi_dot - 2*L*R^3*d*m_b*m_w*tau_L*sin(phi(t)) + 2*L*R^3*d*m_b*m_w*tau_R*sin(phi(t)) + I_yw*L^2*R^2*d*m_b^2*cos(phi(t))*phi_dot^2 + 8*L^2*R^4*d*m_b*m_w^2*cos(phi(t))*phi_dot^2 + 4*L^2*R^4*d*m_b^2*m_w*cos(phi(t))*phi_dot^2 + 4*I_yw*I_zb*R^2*d*m_b*cos(phi(t))*phi_dot^2 - 8*I_yw*L^2*R^2*m_w^2*cos(2*phi(t))*Y_dot*phi_dot - I_yw*L*R*d*m_b*tau_L*sin(phi(t)) + I_yw*L*R*d*m_b*tau_R*sin(phi(t)) - 8*I_yw*L^2*R^2*m_w^2*sin(2*phi(t))*X_dot*phi_dot - 2*I_yw*R^2*d^2*m_b^2*cos(2*phi(t))*Y_dot*phi_dot + 4*I_yw*R^4*d*m_b*m_w*cos(phi(t))*phi_dot^2 + 8*I_zb*R^4*d*m_b*m_w*cos(phi(t))*phi_dot^2 - 4*I_yw*R^2*d^2*m_b*m_w*cos(2*phi(t))*Y_dot*phi_dot + 4*I_yw*L^2*R^2*d*m_b*m_w*cos(3*phi(t))*phi_dot^2 - 4*I_yw*R^2*d^2*m_b*m_w*sin(2*phi(t))*X_dot*phi_dot + 6*I_yw*L^2*R^2*d*m_b*m_w*cos(phi(t))*phi_dot^2 - 4*I_yw*L^2*R^2*m_b*m_w*cos(2*phi(t))*Y_dot*phi_dot - 4*I_yw*L^2*R^2*m_b*m_w*sin(2*phi(t))*X_dot*phi_dot)/(2*I_yw^2*L^2*m_b + 4*I_yw^2*L^2*m_w + 4*I_yw^2*R^2*m_b + 2*I_yw*R^4*m_b^2 + 4*I_zb*R^4*m_b^2 + 8*I_yw^2*R^2*m_w + 8*I_yw*R^4*m_w^2 + 16*I_zb*R^4*m_w^2 + 16*L^2*R^4*m_w^3 + 8*R^4*d^2*m_b*m_w^2 + 4*R^4*d^2*m_b^2*m_w + 8*I_yw*I_zb*R^2*m_b + 16*I_yw*I_zb*R^2*m_w + 8*I_yw*R^4*m_b*m_w + 16*I_zb*R^4*m_b*m_w + I_yw*L^2*R^2*m_b^2 + 20*I_yw*L^2*R^2*m_w^2 + 2*I_yw*R^2*d^2*m_b^2 + 16*L^2*R^4*m_b*m_w^2 + 4*L^2*R^4*m_b^2*m_w + 2*I_yw*R^2*d^2*m_b^2*cos(4*phi(t)) + 12*I_yw*L^2*R^2*m_b*m_w + 8*I_yw*R^2*d^2*m_b*m_w);
Y_dotdot2 = (8*L^2*R^3*m_w^2*tau_L*cos(phi(t)) + 8*L^2*R^3*m_w^2*tau_R*cos(phi(t)) - 2*R^3*d^2*m_b^2*tau_L*cos(phi(t)) - 2*R^3*d^2*m_b^2*tau_R*cos(phi(t)) + 2*I_yw*R^3*m_b*tau_L*cos(phi(t)) + 2*I_yw*R^3*m_b*tau_R*cos(phi(t)) + 4*I_zb*R^3*m_b*tau_L*cos(phi(t)) + 4*I_zb*R^3*m_b*tau_R*cos(phi(t)) + 4*I_yw*R^3*m_w*tau_L*cos(phi(t)) + 4*I_yw*R^3*m_w*tau_R*cos(phi(t)) + 8*I_zb*R^3*m_w*tau_L*cos(phi(t)) + 8*I_zb*R^3*m_w*tau_R*cos(phi(t)) + 4*R^3*d^2*m_b^2*tau_L*cos(phi(t))^3 + 4*R^3*d^2*m_b^2*tau_R*cos(phi(t))^3 - 2*I_yw^2*L^2*m_b*cos(phi(t))^2*X_dot*phi_dot - 4*I_yw^2*L^2*m_w*cos(phi(t))^2*X_dot*phi_dot - 4*I_yw^2*R^2*m_b*cos(phi(t))^2*X_dot*phi_dot - 8*I_yw^2*R^2*m_w*cos(phi(t))^2*X_dot*phi_dot + I_yw^2*L^2*m_b*sin(2*phi(t))*Y_dot*phi_dot + 2*I_yw^2*L^2*m_w*sin(2*phi(t))*Y_dot*phi_dot + 2*I_yw^2*R^2*m_b*sin(2*phi(t))*Y_dot*phi_dot + 4*I_yw^2*R^2*m_w*sin(2*phi(t))*Y_dot*phi_dot + L*R^3*d*m_b^2*tau_L*cos(phi(t)) - L*R^3*d*m_b^2*tau_R*cos(phi(t)) + 4*L^2*R^3*m_b*m_w*tau_L*cos(phi(t)) + 4*L^2*R^3*m_b*m_w*tau_R*cos(phi(t)) + 4*I_yw^2*L^2*d*m_b*sin(phi(t))^3*phi_dot^2 - 4*I_yw*R^2*d^3*m_b^2*sin(phi(t))*phi_dot^2 + 8*I_yw^2*R^2*d*m_b*sin(phi(t))^3*phi_dot^2 + 4*R^3*d^2*m_b*m_w*tau_L*cos(phi(t)) + 4*R^3*d^2*m_b*m_w*tau_R*cos(phi(t)) + 4*R^4*d^3*m_b^2*m_w*sin(phi(t))*phi_dot^2 - 2*R^4*d^2*m_b^3*cos(phi(t))^2*X_dot*phi_dot - R^4*d^2*m_b^3*sin(2*phi(t))*Y_dot*phi_dot + 8*I_yw*R^2*d^3*m_b^2*sin(phi(t))^3*phi_dot^2 + I_yw*L^2*R*m_b*tau_L*cos(phi(t)) + I_yw*L^2*R*m_b*tau_R*cos(phi(t)) + 2*I_yw*L^2*R*m_w*tau_L*cos(phi(t)) + 2*I_yw*L^2*R*m_w*tau_R*cos(phi(t)) - 2*I_yw^2*L^2*d*m_b*sin(phi(t))*phi_dot^2 - 4*I_yw^2*R^2*d*m_b*sin(phi(t))*phi_dot^2 + 2*I_yw*R^4*d*m_b^2*sin(phi(t))*phi_dot^2 + 4*I_zb*R^4*d*m_b^2*sin(phi(t))*phi_dot^2 - 6*I_yw*R^2*d^2*m_b^2*sin(2*phi(t))*Y_dot*phi_dot + 4*I_yw*R^4*d*m_b*m_w*sin(phi(t))*phi_dot^2 + 8*I_zb*R^4*d*m_b*m_w*sin(phi(t))*phi_dot^2 - 4*R^4*d^2*m_b^2*m_w*cos(phi(t))^2*X_dot*phi_dot - 8*I_yw*I_zb*R^2*m_b*cos(phi(t))^2*X_dot*phi_dot - 16*I_yw*I_zb*R^2*m_w*cos(phi(t))^2*X_dot*phi_dot - 2*R^4*d^2*m_b^2*m_w*sin(2*phi(t))*Y_dot*phi_dot + 4*I_yw*I_zb*R^2*m_b*sin(2*phi(t))*Y_dot*phi_dot + 8*I_yw*I_zb*R^2*m_w*sin(2*phi(t))*Y_dot*phi_dot - 4*I_yw*L*R*d*m_b*tau_L*cos(phi(t))^3 + 4*I_yw*L*R*d*m_b*tau_R*cos(phi(t))^3 + 16*I_yw*I_zb*R^2*d*m_b*sin(phi(t))^3*phi_dot^2 + 2*L*R^3*d*m_b*m_w*tau_L*cos(phi(t)) - 2*L*R^3*d*m_b*m_w*tau_R*cos(phi(t)) + I_yw*L^2*R^2*d*m_b^2*sin(phi(t))*phi_dot^2 + 8*L^2*R^4*d*m_b*m_w^2*sin(phi(t))*phi_dot^2 + 4*L^2*R^4*d*m_b^2*m_w*sin(phi(t))*phi_dot^2 + 4*I_yw*L*R*d*m_b*tau_L*cos(phi(t)) - 4*I_yw*L*R*d*m_b*tau_R*cos(phi(t)) - 16*I_yw*L^2*R^2*m_w^2*cos(phi(t))^2*X_dot*phi_dot - 8*I_yw*I_zb*R^2*d*m_b*sin(phi(t))*phi_dot^2 + 8*I_yw*L^2*R^2*m_w^2*sin(2*phi(t))*Y_dot*phi_dot - 4*I_yw*R^2*d^2*m_b^2*cos(phi(t))^2*X_dot*phi_dot - 8*I_yw*R^2*d^2*m_b*m_w*cos(phi(t))^2*X_dot*phi_dot + 4*I_yw*R^2*d^2*m_b*m_w*sin(2*phi(t))*Y_dot*phi_dot + 16*I_yw*L^2*R^2*d*m_b*m_w*sin(phi(t))^3*phi_dot^2 + 16*I_yw*R^2*d^2*m_b^2*cos(phi(t))^3*sin(phi(t))*Y_dot*phi_dot - 6*I_yw*L^2*R^2*d*m_b*m_w*sin(phi(t))*phi_dot^2 - 8*I_yw*L^2*R^2*m_b*m_w*cos(phi(t))^2*X_dot*phi_dot + 4*I_yw*L^2*R^2*m_b*m_w*sin(2*phi(t))*Y_dot*phi_dot)/(2*I_yw^2*L^2*m_b + 4*I_yw^2*L^2*m_w + 4*I_yw^2*R^2*m_b + 2*I_yw*R^4*m_b^2 + 4*I_zb*R^4*m_b^2 + 8*I_yw^2*R^2*m_w + 8*I_yw*R^4*m_w^2 + 16*I_zb*R^4*m_w^2 + 16*L^2*R^4*m_w^3 + 8*R^4*d^2*m_b*m_w^2 + 4*R^4*d^2*m_b^2*m_w + 8*I_yw*I_zb*R^2*m_b + 16*I_yw*I_zb*R^2*m_w + 8*I_yw*R^4*m_b*m_w + 16*I_zb*R^4*m_b*m_w + I_yw*L^2*R^2*m_b^2 + 20*I_yw*L^2*R^2*m_w^2 + 2*I_yw*R^2*d^2*m_b^2 + 16*L^2*R^4*m_b*m_w^2 + 4*L^2*R^4*m_b^2*m_w + 2*I_yw*R^2*d^2*m_b^2*cos(4*phi(t)) + 12*I_yw*L^2*R^2*m_b*m_w + 8*I_yw*R^2*d^2*m_b*m_w);
phi_dotdot2 =(L*R^3*m_b^2*tau_R - L*R^3*m_b^2*tau_L - 4*L*R^3*m_w^2*tau_L + 4*L*R^3*m_w^2*tau_R + 2*R^3*d*m_b^2*tau_L + 2*R^3*d*m_b^2*tau_R - 2*I_yw*L*R*m_b*tau_L + 2*I_yw*L*R*m_b*tau_R - 4*I_yw*L*R*m_w*tau_L + 4*I_yw*L*R*m_w*tau_R - 4*R^3*d*m_b^2*tau_L*cos(phi(t))^2 - 4*R^3*d*m_b^2*tau_R*cos(phi(t))^2 - 4*L*R^3*m_b*m_w*tau_L + 4*L*R^3*m_b*m_w*tau_R + 4*R^3*d*m_b*m_w*tau_L + 4*R^3*d*m_b*m_w*tau_R - 8*R^3*d*m_b*m_w*tau_L*cos(phi(t))^2 - 8*R^3*d*m_b*m_w*tau_R*cos(phi(t))^2 + 2*R^4*d*m_b^3*cos(phi(t))*X_dot*phi_dot + 2*R^4*d*m_b^3*sin(phi(t))*Y_dot*phi_dot + 16*I_yw*R^2*d^2*m_b^2*cos(phi(t))^3*sin(phi(t))*phi_dot^2 + 8*I_yw*R^2*d*m_b^2*sin(phi(t))*Y_dot*phi_dot + 8*R^4*d*m_b*m_w^2*cos(phi(t))*X_dot*phi_dot + 8*R^4*d*m_b^2*m_w*cos(phi(t))*X_dot*phi_dot + 8*R^4*d*m_b*m_w^2*sin(phi(t))*Y_dot*phi_dot + 8*R^4*d*m_b^2*m_w*sin(phi(t))*Y_dot*phi_dot + 8*I_yw*R^2*d*m_b^2*cos(phi(t))^3*X_dot*phi_dot - 8*I_yw*R^2*d^2*m_b^2*cos(phi(t))*sin(phi(t))*phi_dot^2 + 16*I_yw*R^2*d*m_b*m_w*sin(phi(t))*Y_dot*phi_dot + 16*I_yw*R^2*d*m_b*m_w*cos(phi(t))^3*X_dot*phi_dot - 8*I_yw*R^2*d*m_b^2*cos(phi(t))^2*sin(phi(t))*Y_dot*phi_dot - 16*I_yw*R^2*d*m_b*m_w*cos(phi(t))^2*sin(phi(t))*Y_dot*phi_dot)/(2*I_yw^2*L^2*m_b + 4*I_yw^2*L^2*m_w + 4*I_yw^2*R^2*m_b + 2*I_yw*R^4*m_b^2 + 4*I_zb*R^4*m_b^2 + 8*I_yw^2*R^2*m_w + 8*I_yw*R^4*m_w^2 + 16*I_zb*R^4*m_w^2 + 16*L^2*R^4*m_w^3 + 8*R^4*d^2*m_b*m_w^2 + 4*R^4*d^2*m_b^2*m_w + 8*I_yw*I_zb*R^2*m_b + 16*I_yw*I_zb*R^2*m_w + 8*I_yw*R^4*m_b*m_w + 16*I_zb*R^4*m_b*m_w + I_yw*L^2*R^2*m_b^2 + 20*I_yw*L^2*R^2*m_w^2 + 2*I_yw*R^2*d^2*m_b^2 + 16*L^2*R^4*m_b*m_w^2 + 4*L^2*R^4*m_b^2*m_w + 2*I_yw*R^2*d^2*m_b^2*cos(4*phi(t)) + 12*I_yw*L^2*R^2*m_b*m_w + 8*I_yw*R^2*d^2*m_b*m_w);
%
%j k l
Ma = 2*I_yw+R^2*m_b+2*R^2*m_w; 

j1 = R * sin(phi)/ Ma;
j2 = R * sin(phi)/ Ma;

k1 = R * cos(phi)/ Ma;
k2 = R * cos(phi)/ Ma;

l1 = L*R/(I_yw*L^2 + 2*I_zb*R^2 + 4*I_zw*R^2 + L^2*R^2*m_w);
l2 = -L*R/(I_yw*L^2 + 2*I_zb*R^2 + 4*I_zw*R^2 + L^2*R^2*m_w);

D_2 = [j1,j2
       k1,k2
       l1,l2];
D_inv2 = simplify(inv(D_2.'*D_2)*D_2.');

a1 = (R*sin(phi(t))*(diff(W_L(t), t, t) + diff(W_R(t), t, t)))/2 + (R*cos(phi(t))*(diff(W_L(t), t) + diff(W_R(t), t))*phi_dot(t))/2;
a2 = (R*cos(phi(t))*(diff(W_L(t), t, t) + diff(W_R(t), t, t)))/2 - (R*sin(phi(t))*(diff(W_L(t), t) + diff(W_R(t), t))*phi_dot(t))/2;
a3 = (R*(diff(W_L(t), t, t) + diff(W_R(t), t, t)))/L;

D_dotdot2 = [a1,
             a2,
             a3];
D_final2 = simplify(D_inv2 * D_dotdot2);

