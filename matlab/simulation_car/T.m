function T = T(m_w,m_b,g,I_xb,I_yb,I_zb,I_xw,I_yw,I_zw ...
         ,phi_x_dot,phi_y_dot,phi_z_dot,z_w,x_w_dot,y_w_dot,z_w_dot,theta_1_dot,theta_2_dot ...
         ,theta_3_dot,theta_4_dot,L_x,L_y)
    T = 1/2*(m_w+4*m_b)*((x_w_dot)^2+(y_w_dot)^2+(z_w_dot)^2+2*g*z_w)...
      + 1/2*(I_zb*(phi_z_dot)^2+I_xb*(phi_x_dot)^2+I_yb*(phi_y_dot)^2)...
      + 1/2*I_yw*(theta_1_dot+theta_2_dot+theta_3_dot+theta_4_dot)...
      + 2*(I_yw*(phi_y_dot)^2+I_xw*(phi_x_dot)^2+I_zw*(phi_z_dot)^2)...
      + 2*m_w*(phi_x_dot^2*(L_x^2+L_y^2)+phi_y_dot^2*(L_x^2+L_y^2)+phi_z_dot^2*(L_x^2+L_y^2)); 

end