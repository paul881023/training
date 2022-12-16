clc;
close all;
clear all;

syms X_w_posi(t) Y_w_posi(t) Z_w_posi(t) phi_x_posi(t) phi_y_posi(t) phi_z_posi(t)
syms theta_1(t)  theta_2(t)  theta_3(t)  theta_4(t)
syms delta_i alpha(t) beta(t) gamma(t)  
syms phi_x(t) phi_y(t) phi_z(t) X_w(t) Y_w(t) Z_w(t)
syms L_x_i L_y_i L_z_i R theta_dot_i(t)

phi_x_posi(t) = alpha(t);
phi_y_posi(t) = beta(t);
phi_z_posi(t) = gamma(t);


% 定義區
%速度項計算
syms V_w_ex(t) V_w_ey(t) V_w_ez(t)
%角速度計算
syms phi_xVec(t)  phi_yVec(t)  phi_zVec1(t)  phi_zVec2(t) theta_rotation(t)
%方程式呈現
syms V_Q1(t) V_Q2(t) V_Q3(t) V_Q4(t) V_Q(t)
%4輪探討係數設定
syms theta_dot_1(t) theta_dot_2(t) theta_dot_3(t) theta_dot_4(t)
%設定廣義力參數
syms tau_1 tau_2 tau_3 tau_4
%車體運動方程式參數
syms m_b I_xb I_yb I_zb T_body(t)
%車輪運動方程式參數
syms m_w I_xw I_yw I_zw T_1(t) T_2(t) T_3(t) T_4(t)
%位能能量參數
syms V(t)  G %重力加速度
%Lagrange method
syms L(t)
%偏微分係數定義
syms x_w_diff(t) y_w_diff(t) z_w_diff(t) phi_x_diff(t) phi_y_diff(t) phi_z_diff(t)
syms theta_dot_1_diff(t) theta_dot_2_diff(t) theta_dot_3_diff(t) theta_dot_4_diff(t)
syms V_Q_1_diff(t) V_Q_2_diff(t) V_Q_3_diff(t) V_Q_4_diff(t)
%landa定義
syms landa_1 landa_2 landa_3 landa_4
%得到theta_dual_dot_i
syms theta_dual_dot_1 theta_dual_dot_2 theta_dual_dot_3 theta_dual_dot_4
%偏微分右側
syms x_w_diff_right(t) y_w_diff_right z_w_diff_right phi_x_diff_right phi_y_diff_right phi_z_diff_right
%偏微求係數
syms x_double_dot_parameter y_double_dot_parameter z_double_dot_parameter

%解聯立
syms x_dotdot y_dotdot z_dotdot
syms phi_x_dotdot phi_y_dotdot phi_z_dotdot

delta_i =pi/4;
%------------------------

% phi_x(t) = 0; 
% phi_y(t) = 0;
alpha(t) = 0;
% beta(t)  = 0;
% Z_w(t) = 0;
% 
% L_z_i = 0;
% I_xw = 0;
% 
% I_xb = 0;
% I_yb = 0;

%位置微分得到速度
X_w(t) = diff(X_w_posi(t),t);
Y_w(t) = diff(Y_w_posi(t),t);
Z_w(t) = diff(Z_w_posi(t),t);

%角度微分得到角速度
phi_x(t) = diff(phi_x_posi(t),t);
phi_y(t) = diff(phi_y_posi(t),t);
phi_z(t) = diff(phi_z_posi(t),t);

theta_dot_1 = diff(theta_1,t);
theta_dot_2 = diff(theta_2,t);
theta_dot_3 = diff(theta_3,t);
theta_dot_4 = diff(theta_4,t);

%簡化算式
a = cos(beta(t))*cos(gamma(t));
b = -sin(gamma(t))*cos(beta(t));
c = sin(beta(t));
d = sin(alpha(t))*sin(beta(t))*cos(gamma(t))+cos(alpha(t))*sin(gamma(t));
e = -sin(alpha(t))*sin(beta(t))*sin(gamma(t))+cos(alpha(t))*cos(gamma(t));
f = -sin(alpha(t))*cos(beta(t));
g = -sin(beta(t))*cos(alpha(t))*cos(gamma(t))+sin(alpha(t))*sin(gamma(t));
h = sin(gamma(t))*sin(beta(t))*cos(alpha(t))+sin(alpha(a))*cos(gamma(t));
i = cos(alpha(t))*cos(beta(t));

M_rotate = [a, b, c,
            d, e, f,
            g, h, i];
M_rotate_bar = inv(M_rotate);

a = M_rotate_bar(1,1);
b = M_rotate_bar(1,2);
c = M_rotate_bar(1,3);
d = M_rotate_bar(2,1);
e = M_rotate_bar(2,2);
f = M_rotate_bar(2,3);
g = M_rotate_bar(3,1);
h = M_rotate_bar(3,2);
i = M_rotate_bar(3,3);
%大地速度

V_w_ex(t) = X_w(t)*a + Y_w(t)*b + Z_w(t)*c;%ex
V_w_ey(t) = X_w(t)*d + Y_w(t)*e + Z_w(t)*f;%ey
V_w_ez(t) = X_w(t)*g + Y_w(t)*h + Z_w(t)*i;%ez

%車體轉動速度
phi_xVec(t) = -phi_x(t)*L_z_i;%ey
phi_yVec(t) =  phi_y(t)*L_z_i;%ex
phi_zVec1(t) = phi_z(t)*L_x_i;%ey
phi_zVec2(t) = -phi_z(t)*L_y_i;%ex

%車輪轉動速度
theta_rotation(t) = -theta_dot_i(t)*R;

%V_Q 與 E_r之內積 = 0
V_Q(t) = V_w_ex(t)*cos(delta_i) + V_w_ey(t)*sin(delta_i) + phi_xVec(t)*sin(delta_i) + phi_yVec(t)*cos(delta_i) + phi_zVec1(t)*sin(delta_i) +  phi_zVec2(t)*cos(delta_i) - theta_dot_1*R*cos(delta_i);


%轉為矩陣
%設定參數
f_11 = a*cos(-delta_i)+d*sin(-delta_i);
f_12 = b*cos(-delta_i)+e*sin(-delta_i);
f_13 = c*cos(-delta_i)+f*sin(-delta_i);
f_14 = -L_z_i*sin(-delta_i);
f_15 = L_z_i*cos(-delta_i);
f_16 = -L_y_i*cos(-delta_i)+L_x_i*sin(-delta_i);
f_17 = -R*cos(delta_i);
f_18 = 0;
f_19 = 0;
f_110 = 0;

f_21 = a*cos(delta_i)+d*sin(delta_i);
f_22 = b*cos(delta_i)+e*sin(delta_i);
f_23 = c*cos(delta_i)+f*sin(delta_i);
f_24 = -L_z_i*sin(delta_i);
f_25 = L_z_i*cos(delta_i);
f_26 = L_y_i*cos(delta_i)+L_x_i*sin(delta_i);
f_27 = 0;
f_28 = -R*cos(delta_i);
f_29 = 0;
f_210 = 0;

f_31 = a*cos(delta_i)+d*sin(delta_i);
f_32 = b*cos(delta_i)+e*sin(delta_i);
f_33 = c*cos(delta_i)+f*sin(delta_i);
f_34 = -L_z_i*sin(delta_i);
f_35 = L_z_i*cos(delta_i);
f_36 = -L_y_i*cos(delta_i)-L_x_i*sin(delta_i);
f_37 = 0;
f_38 = 0;
f_39 = -R*cos(delta_i);
f_310 = 0;

f_41 = a*cos(-delta_i)+d*sin(-delta_i);
f_42 = b*cos(-delta_i)+e*sin(-delta_i);
f_43 = c*cos(-delta_i)+f*sin(-delta_i);
f_44 = -L_z_i*sin(-delta_i);
f_45 = L_z_i*cos(-delta_i);
f_46 = L_y_i*cos(-delta_i)-L_x_i*sin(-delta_i);
f_47 = 0;
f_48 = 0;
f_49 = 0;
f_410 = -R*cos(delta_i);

%設定V_Q(t) 以方程式表達
V_Q1(t) = simplify(f_11*X_w(t) + f_12*Y_w(t) + f_13*Z_w(t) + f_14*phi_x(t) + f_15* phi_y(t) + f_16*phi_z(t) ...
        + f_17 * theta_dot_1(t) + f_18 * theta_dot_2(t) + f_19 * theta_dot_3(t) + f_110 * theta_dot_4(t));
V_Q2(t) = simplify(f_21*X_w(t) + f_22*Y_w(t) + f_23*Z_w(t) + f_24*phi_x(t) + f_25* phi_y(t) + f_26*phi_z(t) ...
        + f_27 * theta_dot_1(t) + f_28 * theta_dot_2(t) + f_29 * theta_dot_3(t) + f_210 * theta_dot_4(t));
V_Q3(t) = simplify(f_31*X_w(t) + f_32*Y_w(t) + f_33*Z_w(t) + f_34*phi_x(t) + f_35* phi_y(t) + f_36*phi_z(t) ...
        + f_37 * theta_dot_1(t) + f_38 * theta_dot_2(t) + f_39 * theta_dot_3(t) + f_310 * theta_dot_4(t));
V_Q4(t) = simplify(f_41*X_w(t) + f_42*Y_w(t) + f_43*Z_w(t) + f_44*phi_x(t) + f_45* phi_y(t) + f_46*phi_z(t) ...
        + f_47 * theta_dot_1(t) + f_48 * theta_dot_2(t) + f_49 * theta_dot_3(t) + f_410 * theta_dot_4(t));

dynamic_matrix = [f_11,f_12,f_13,f_14,f_15,f_16,
                  f_21,f_22,f_23,f_24,f_25,f_26,
                  f_31,f_32,f_33,f_34,f_35,f_36,
                  f_41,f_42,f_43,f_44,f_45,f_46,];

dynamic_para =   [X_w(t),
                  Y_w(t),
                  Z_w(t),
                  phi_x(t),
                  phi_y(t),
                  phi_z(t),
                  theta_dot_1(t),
                  theta_dot_2(t),
                  theta_dot_3(t),
                  theta_dot_4(t)];

dynamic_set = [f_17,
               f_28,
               f_39,
               f_410];
%轉為約束式
constraint_parameter = [f_11,f_12,f_13,f_14,f_15,f_16,f_17,f_18,f_19,f_110,
                        f_21,f_22,f_23,f_24,f_25,f_26,f_27,f_28,f_29,f_210,
                        f_31,f_32,f_33,f_34,f_35,f_36,f_37,f_38,f_39,f_310,
                        f_41,f_42,f_43,f_44,f_45,f_46,f_47,f_48,f_49,f_410];

%設定廣義力
Q1 = 0;
Q2 = 0;
Q3 = 0;
Q4 = 0;
Q5 = 0;
Q6 = 0;
Q7 = tau_1;
Q8 = tau_2;
Q9 = tau_3;
Q10 = tau_4;

%車體運動方程式
T_body(t) = simplify(1/2*m_b*(X_w(t)^2 + Y_w(t)^2 + Z_w(t)^2)...
          + 1/2*(I_xb*phi_x(t)^2 + I_yb*phi_y(t)^2 + I_zb*phi_z(t)^2));

%車輪運動方程式
T_1(t) = simplify(1/2*m_w*(X_w(t)^2 + Y_w(t)^2 + Z_w(t)^2)...
       + 1/2*(I_xw*phi_x(t)^2 + I_yw*phi_y(t)^2 + I_zw*phi_z(t)^2 + I_yw*theta_dot_1(t)^2)...
       + 1/2*m_w*(L_x_i^2 + L_y_i^2 + L_z_i^2)*phi_x(t)^2 ...
       + 1/2*m_w*(L_x_i^2 + L_y_i^2 + L_z_i^2)*phi_y(t)^2 ...
       + 1/2*m_w*(L_x_i^2 + L_y_i^2 + L_z_i^2)*phi_z(t)^2);

T_2(t) = simplify(1/2*m_w*(X_w(t)^2 + Y_w(t)^2 + Z_w(t)^2)...
       + 1/2*(I_xw*phi_x(t)^2 + I_yw*phi_y(t)^2 + I_zw*phi_z(t)^2 + I_yw*theta_dot_2(t)^2)...
       + 1/2*m_w*(L_x_i^2 + L_y_i^2 + L_z_i^2)*phi_x(t)^2 ...
       + 1/2*m_w*(L_x_i^2 + L_y_i^2 + L_z_i^2)*phi_y(t)^2 ...
       + 1/2*m_w*(L_x_i^2 + L_y_i^2 + L_z_i^2)*phi_z(t)^2);

T_3(t) = simplify(1/2*m_w*(X_w(t)^2 + Y_w(t)^2 + Z_w(t)^2)...
       + 1/2*(I_xw*phi_x(t)^2 + I_yw*phi_y(t)^2 + I_zw*phi_z(t)^2 + I_yw*theta_dot_3(t)^2)...
       + 1/2*m_w*(L_x_i^2 + L_y_i^2 + L_z_i^2)*phi_x(t)^2 ...
       + 1/2*m_w*(L_x_i^2 + L_y_i^2 + L_z_i^2)*phi_y(t)^2 ...
       + 1/2*m_w*(L_x_i^2 + L_y_i^2 + L_z_i^2)*phi_z(t)^2);

T_4(t) = simplify(1/2*m_w*(X_w(t)^2 + Y_w(t)^2 + Z_w(t)^2)...
       + 1/2*(I_xw*phi_x(t)^2 + I_yw*phi_y(t)^2 + I_zw*phi_z(t)^2 + I_yw*theta_dot_4(t)^2)...
       + 1/2*m_w*(L_x_i^2 + L_y_i^2 + L_z_i^2)*phi_x(t)^2 ...
       + 1/2*m_w*(L_x_i^2 + L_y_i^2 + L_z_i^2)*phi_y(t)^2 ...
       + 1/2*m_w*(L_x_i^2 + L_y_i^2 + L_z_i^2)*phi_z(t)^2);



%位能能量
V(t) = simplify((4*m_w + m_b)*G*Z_w_posi(t));

%Lagrange method 總能量
L(t) = simplify(T_body(t) + T_1(t) + T_2(t) + T_3(t) + T_4(t) - V(t));

%帶入Lagrange method 做偏微分
x_w_diff(t)  = simplify(diff(diff(L(t),X_w),t) - diff(L(t),X_w_posi));
y_w_diff(t)  = simplify(diff(diff(L(t),Y_w),t) - diff(L(t),Y_w_posi));
z_w_diff(t)  = simplify(diff(diff(L(t),Z_w),t) - diff(L(t),Z_w_posi));

phi_x_diff(t)  = simplify(diff(diff(L(t),phi_x),t) - diff(L(t),phi_x_posi));
phi_y_diff(t)  = simplify(diff(diff(L(t),phi_y),t) - diff(L(t),phi_y_posi));
phi_z_diff(t)  = simplify(diff(diff(L(t),phi_z),t) - diff(L(t),phi_z_posi));

% phi_x_diff(t)  = simplify(diff(diff(L(t),phi_x),t) - diff(L(t),alpha));
% phi_y_diff(t)  = simplify(diff(diff(L(t),phi_y),t) - diff(L(t),beta));
% phi_z_diff(t)  = simplify(diff(diff(L(t),phi_z),t) - diff(L(t),gamma));

theta_dot_1_diff(t) = simplify(diff(diff(L(t),theta_dot_1),t) -  diff(L(t),theta_1));
theta_dot_2_diff(t) = simplify(diff(diff(L(t),theta_dot_2),t) -  diff(L(t),theta_2));
theta_dot_3_diff(t) = simplify(diff(diff(L(t),theta_dot_3),t) -  diff(L(t),theta_3));
theta_dot_4_diff(t) = simplify(diff(diff(L(t),theta_dot_4),t) -  diff(L(t),theta_4));

%對V_Q微分
V_Q_1_diff(t) = simplify(diff(V_Q1,t));
V_Q_2_diff(t) = simplify(diff(V_Q2,t));
V_Q_3_diff(t) = simplify(diff(V_Q3,t));
V_Q_4_diff(t) = simplify(diff(V_Q4,t));

%得到theta_dual_dot_i
theta_dual_dot_1 = simplify((V_Q_1_diff(t) + R*cos(delta_i)*diff(diff(theta_1,t)))/(R*cos(delta_i)));
theta_dual_dot_2 = simplify((V_Q_2_diff(t) + R*cos(delta_i)*diff(diff(theta_2,t)))/(R*cos(delta_i)));
theta_dual_dot_3 = simplify((V_Q_3_diff(t) + R*cos(delta_i)*diff(diff(theta_3,t)))/(R*cos(delta_i)));
theta_dual_dot_4 = simplify((V_Q_4_diff(t) + R*cos(delta_i)*diff(diff(theta_4,t)))/(R*cos(delta_i)));

landa_1 = simplify((tau_1 - theta_dual_dot_1(t)*I_yw)/(R*cos(delta_i)));
landa_2 = simplify((tau_2 - theta_dual_dot_2(t)*I_yw)/(R*cos(delta_i)));
landa_3 = simplify((tau_3 - theta_dual_dot_3(t)*I_yw)/(R*cos(delta_i)));
landa_4 = simplify((tau_4 - theta_dual_dot_4(t)*I_yw)/(R*cos(delta_i)));

%帶回上式
x_w_diff_right = simplify(landa_1*f_11 + landa_2*f_21 + landa_3*f_31 + landa_4*f_41);
y_w_diff_right = simplify(landa_1*f_12 + landa_2*f_22 + landa_3*f_32 + landa_4*f_42);
z_w_diff_right = simplify(landa_1*f_13 + landa_2*f_23 + landa_3*f_33 + landa_4*f_43);
phi_x_diff_right = simplify(landa_1*f_14 + landa_2*f_24 + landa_3*f_34 + landa_4*f_44);
phi_y_diff_right = simplify(landa_1*f_15 + landa_2*f_25 + landa_3*f_35 + landa_4*f_45);
phi_z_diff_right = simplify(landa_1*f_16 + landa_2*f_26 + landa_3*f_36 + landa_4*f_46);

% %移項整理(右)
x_double_dot_final_right = simplify(x_w_diff_right + 4 *(I_yw)/R^2*(cos(beta(t)))^2*diff(X_w(t),t));
y_double_dot_final_right = simplify(y_w_diff_right + 4 *(I_yw)/R^2*diff(Y_w(t),t));
z_double_dot_final_right = simplify(z_w_diff_right - 4 *(I_yw*(cos(beta(t))^2-1)/R^2*diff(Z_w(t),t)));
phi_x_double_dot_final_right = simplify(phi_x_diff_right + 4 *(I_yw)/(R^2)*L_z_i^2*diff(phi_x(t),t));
phi_y_double_dot_final_right = simplify(phi_y_diff_right + 4 *(I_yw)/(R^2)*L_z_i^2*diff(phi_y(t),t));
phi_z_double_dot_final_right = simplify(phi_z_diff_right + 4 *(I_yw)/(R^2)*(L_x_i + L_y_i)^2*diff(phi_z(t),t));

% %移項整理(左)
x_w_diff_left = simplify(x_w_diff(t) + 2 *(I_yw)/R^2*(cos(2*beta(t))+1)*diff(X_w(t),t));
y_w_diff_left = simplify(y_w_diff(t) + 4 *(I_yw)/R^2*diff(Y_w(t),t));
z_w_diff_left = simplify(z_w_diff(t) + 2 *(I_yw)/R^2*(cos(2*beta(t))+1)*diff(Z_w(t),t));
phi_x_diff_left = simplify(phi_x_diff(t) + 4 *(I_yw)/(R^2)*L_z_i^2*diff(phi_x(t),t));
phi_y_diff_left = phi_y_diff(t) + 4 *(I_yw)/(R^2)*L_z_i^2*diff(phi_y(t),t);
phi_z_diff_left = phi_z_diff(t) + 4 *(I_yw)/(R^2)*(L_x_i + L_y_i)^2*diff(phi_z(t),t);

%解聯立

a3 = simplify(phi_z_diff_left / diff(phi_z(t),t));
phi_z_dotdot = simplify(phi_z_double_dot_final_right / a3);

%g h i j k (x_w_dotdot y_w_dotdot z_w_dotdot phi_y_dotdot phi_z_dotdot)
%
g= x_w_diff_right - x_w_diff ;

g1 = - (m_b + 4*m_w) + cos(beta(t)) / R^2 * (- 4*I_yw*cos(beta(t)));
g2 = 0;
g3 = cos(beta(t)) / R^2 * 4*I_yw*sin(beta(t));
g4 = - 4*I_yw*L_z_i*cos(gamma(t));
g5 = 0;

c1 = simplify((cos(beta(t))*(- 4*I_yw*diff(Y_w_posi(t), t)*diff(gamma(t), t) + R*tau_1*cos(gamma(t)) + R*tau_2*cos(gamma(t)) + R*tau_3*cos(gamma(t)) + R*tau_4*cos(gamma(t)) + R*tau_1*sin(gamma(t))...
      - R*tau_2*sin(gamma(t)) - R*tau_3*sin(gamma(t)) + R*tau_4*sin(gamma(t)) + 4*I_yw*cos(beta(t))*diff(Z_w_posi(t), t)*diff(beta(t), t) + 4*I_yw*sin(beta(t))*diff(X_w_posi(t), t)*diff(beta(t), t)...
      - 4*I_yw*L_z_i*sin(gamma(t))*diff(alpha(t), t, t)))/R^2);

%
h = y_w_diff_right - y_w_diff;

h1 = 0;
h2 = - (m_b + 4*m_w) + (- 4*I_yw) / R^2 ;
h3 = 0;
h4 = - 4*I_yw*L_z_i*sin(gamma(t));
h5 = 0;

c2 = simplify((R*tau_2*cos(gamma(t)) - R*tau_1*cos(gamma(t))  + R*tau_3*cos(gamma(t)) - R*tau_4*cos(gamma(t)) + R*tau_1*sin(gamma(t)) + R*tau_2*sin(gamma(t)) + R*tau_3*sin(gamma(t)) + R*tau_4*sin(gamma(t))...
   + 4*I_yw*cos(beta(t))*diff(X_w_posi(t), t)*diff(gamma(t), t) - 4*I_yw*sin(beta(t))*diff(Z_w_posi(t), t)*diff(gamma(t), t) + 4*I_yw*L_z_i*cos(gamma(t))*diff(alpha(t), t, t) )/R^2) ;

%
i = z_w_diff_right - z_w_diff;

i1 = 2*I_yw*sin(2*beta(t))/R^2;
i2 = 0;
i3 = -(4*I_yw- 4*I_yw*cos(beta(t))^2)/R^2 - (m_b + 4*m_w);
i4 = -(4*I_yw*L_z_i*cos(gamma(t)));
i5 = 0;

c3 = - simplify(( 4*I_yw*diff(X_w_posi(t), t)*diff(beta(t), t) - 4*I_yw*sin(beta(t))*diff(Y_w_posi(t), t)*diff(gamma(t), t) ...
     - 4*I_yw*cos(beta(t))^2*diff(X_w_posi(t), t)*diff(beta(t), t) + 2*I_yw*sin(2*beta(t))*diff(Z_w_posi(t), t)*diff(beta(t), t) + R*tau_1*cos(gamma(t))*sin(beta(t)) + R*tau_2*cos(gamma(t))*sin(beta(t))...
     + R*tau_3*cos(gamma(t))*sin(beta(t)) + R*tau_4*cos(gamma(t))*sin(beta(t)) + R*tau_1*sin(beta(t))*sin(gamma(t)) - R*tau_2*sin(beta(t))*sin(gamma(t)) - R*tau_3*sin(beta(t))*sin(gamma(t)) + R*tau_4*sin(beta(t))*sin(gamma(t)) ...
     - 4*I_yw*L_z_i*sin(beta(t))*sin(gamma(t))*diff(alpha(t), t, t))/R^2 - (m_b + 4*m_w)*G);

%
j = phi_y_diff_right - phi_y_diff;

j1 = -(4*I_yw*L_z_i*cos(beta(t))*cos(gamma(t)))/R^2;
j2 = -(4*I_yw*L_z_i*sin(gamma(t)))/R^2;
j3 = (4*I_yw*L_z_i*sin(beta(t))*cos(gamma(t)))/R^2;
j4 = (4*m_w*L_x_i^2 + 4*m_w*L_y_i^2 + 4*m_w*L_z_i^2 + I_yb + 4*I_yw) - (4*I_yw*L_z_i^2)/R^2;
j5 = 0;

c4 = simplify((L_z_i*tau_1)/R  + (L_z_i*tau_2)/R + (L_z_i*tau_3)/R + (L_z_i*tau_4)/R - (4*I_yw*L_z_i*cos(gamma(t))*diff(Y_w_posi(t), t)*diff(gamma(t), t))/R^2 ...
     + (4*I_yw*L_z_i*cos(beta(t))*cos(gamma(t))*diff(Z_w_posi(t), t)*diff(beta(t), t))/R^2 + (4*I_yw*L_z_i*cos(gamma(t))*sin(beta(t))*diff(X_w_posi(t), t)*diff(beta(t), t))/R^2 ... 
     + (4*I_yw*L_z_i*cos(beta(t))*sin(gamma(t))*diff(X_w_posi(t), t)*diff(gamma(t), t))/R^2 - (4*I_yw*L_z_i*sin(beta(t))*sin(gamma(t))*diff(Z_w_posi(t), t)*diff(gamma(t), t))/R^2);


%
k = phi_z_diff_right - phi_z_diff;
k1 = 0;
k2 = 0;
k3 = 0;
k4 = 0;
k5 = -(4*m_w*L_x_i^2 + 4*m_w*L_y_i^2 + 4*m_w*L_z_i^2 + I_zb + 4*I_zw) - (L_x_i + L_y_i)*(4*I_yw*L_x_i + 4*I_yw*L_y_i)/R^2;

c5 = - simplify((L_x_i + L_y_i)*(R*tau_1 - R*tau_2 + R*tau_3 - R*tau_4)/R^2);


M = [g1, g2, g3, g4, g5,
     h1, h2, h3, h4, h5,
     i1, i2, i3, i4, i5,
     j1, j2, j3, j4, j5,
     k1, k2, k3, k4, k5];

C = [c1,
     c2,
     c3,
     c4,
     c5];

P = [diff(X_w_posi,t,t),
     diff(Y_w_posi,t,t),
     diff(Z_w_posi,t,t),
     diff(phi_x_posi,t,t),
     diff(phi_y_posi,t,t)
    ];   

M_bar = inv(M);

P = simplify(mtimes(M_bar,-C));


