clc;clear all;close all;

syms X(t) Y(T) phi(t)
syms L R omega_l(t) omega_r(t) d
syms m_w m_c I_w I_m I_c

TAU = [-sin(phi(t)),cos(phi(t)),0,0,0
        cos(phi(t)),sin(phi(t)),L,-R,0 
        cos(phi(t)),sin(phi(t)),-L,0,-R];

M = [R/2*sin(phi(t)) ,R/2*sin(phi(t))
     R/2*cos(phi(t)) ,R/2*cos(phi(t))
     R/L            ,-R/L];

Xc_dot_2 = diff(X(t) + d*cos(phi(t)),t)^2;
Yc_dot_2 = diff(Y(t) + d*sin(phi(t)),t)^2;

X_wR_dot_2 = diff(X(t) + L*sin(phi(t)),t)^2;
Y_wR_dot_2 = diff(Y(t) + L*cos(phi(t)),t)^2;

X_wL_dot_2 = diff(X(t) - L*sin(phi(t)),t)^2;
Y_wL_dot_2 = diff(Y(t) - L*cos(phi(t)),t)^2;

V_c = Xc_dot_2 + Yc_dot_2;
V_wR = X_wR_dot_2 + Y_wR_dot_2;
V_wL = X_wL_dot_2 + Y_wL_dot_2;

T_total = 1/2*m_c*V_c + 1/2 * I_c * diff(phi(t),t)^2 + 1/2*m_w*(V_wR + V_wL) + I_m*diff(phi(t),t)^2 + 1/2*I_w*(omega_l(t) + omega_r(t));

C1 = diff(diff(T_total,diff(X(t),t)),t) + diff(T_total,X(t));
C2 = diff(diff(T_total,diff(Y(t),t)),t) + diff(T_total,Y(t));
C3 = diff(diff(T_total,diff(phi(t),t)),t) + diff(T_total,phi(t));
C4 = diff(diff(T_total,diff(omega_l(t),t)),t) + diff(T_total,omega_l(t));
C5 = diff(diff(T_total,diff(omega_r(t),t)),t) + diff(T_total,omega_r(t));

%accleration
A_q = [m_c+2*m_w ,0 ,-m_c*d*sin(theta) ,0 ,0
       0 ,m_c+2*m_w , m_c*d*cos(theta) ,0 ,0
       -m_c*d*sin(theta) ,m_c*d*cos(theta) ,I_c+m_c*d^2+2*m_w*L^2+2*I_m ,0 ,0
       0 ,0 ,0 ,I_w/2 ,0
        0 ,0 ,0 ,0 ,I_w/2
       ];

%velocity
