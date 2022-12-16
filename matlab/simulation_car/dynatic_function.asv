close all;
clc;
clear all;


syms  alpha beta gamma  phi_x phi_y phi_z X_dot_r Y_dot_r Z_dot_r R X_w Y_w
syms theta_dot_i L_x_i L_y_i delta_i



%X_w = cos(-gamma)*cos(-beta)*X_dot_r+(-sin(-gamma))*cos(-alpha)*Y_dot_r+cos(-gamma)*sin(-beta)*sin(-alpha)*Z_dot_r;
%Y_w = sin(-gamma)*cos(-beta)*X_dot_r+cos(-gamma)*cos(alpha)*Y_dot_r+sin(-gamma)*sin(-beta)*sin(-alpha)*Z_dot_r;
phi_x = 0;
phi_y = 0;
alpha = 0;
beta  = 0;
Z_w   = 0;


%大地座標轉車體

theta_dot_i = (X_w*(cos(delta_i)*cos(gamma)*cos(beta)+sin(delta_i)*sin(gamma)*cos(beta))...
    + Y_w*(cos(delta_i)*(-sin(gamma))*cos(alpha)+cos(delta_i)*cos(gamma)*sin(beta)*sin(alpha)+sin(delta_i)*cos(gamma)*cos(alpha)+sin(delta_i)*sin(gamma)*sin(beta)*sin(alpha))...
    + Z_w*(cos(delta_i)*sin(gamma)*sin(alpha)+cos(delta_i)*cos(gamma)*sin(beta)*cos(alpha)+sin(delta_i)*(-cos(gamma))*sin(alpha)+sin(delta_i)*sin(gamma)*sin(beta)*cos(alpha))...
    + phi_z*(L_x_i*cos(delta_i)-L_y_i*sin(delta_i))+phi_x*L_y_i-phi_y*L_x_i)/(R*cos(delta_i));



