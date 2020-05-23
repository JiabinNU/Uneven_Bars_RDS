function C = autogen_coriolis_matrix(b1,b2,b3,b4,b5,dtheta_1,dtheta_2,dtheta_3,l_mid,l_top,m_bot,m_mid,m_motor1,m_motor2,m_top,r_com_mid,r_com_bot,r_com_top,theta_1,theta_2,theta_3)
%AUTOGEN_CORIOLIS_MATRIX
%    C = AUTOGEN_CORIOLIS_MATRIX(B1,B2,B3,B4,B5,DTHETA_1,DTHETA_2,DTHETA_3,L_MID,L_TOP,M_BOT,M_MID,M_MOTOR1,M_MOTOR2,M_TOP,R_COM_MID,R_COM_BOT,R_COM_TOP,THETA_1,THETA_2,THETA_3)

%    This function was generated by the Symbolic Math Toolbox version 8.5.
%    22-May-2020 21:16:00

t2 = cos(theta_1);
t3 = sin(theta_1);
t4 = sin(theta_2);
t5 = sin(theta_3);
t6 = theta_1+theta_2;
t7 = theta_2+theta_3;
t18 = m_mid./2.0;
t19 = m_motor1./2.0;
t20 = m_motor2./2.0;
t8 = l_top.*t2;
t9 = cos(t6);
t10 = l_top.*t3;
t11 = sin(t6);
t12 = sin(t7);
t13 = t6+theta_3;
t29 = dtheta_1.*l_mid.*l_top.*m_bot.*t4.*2.0;
t30 = dtheta_2.*l_mid.*l_top.*m_bot.*t4.*2.0;
t33 = dtheta_1.*l_mid.*m_bot.*r_com_bot.*t5.*2.0;
t34 = dtheta_2.*l_mid.*m_bot.*r_com_bot.*t5.*2.0;
t35 = dtheta_3.*l_mid.*m_bot.*r_com_bot.*t5.*2.0;
t36 = dtheta_1.*l_top.*m_mid.*r_com_mid.*t4.*2.0;
t37 = dtheta_2.*l_top.*m_mid.*r_com_mid.*t4.*2.0;
t38 = dtheta_1.*l_top.*m_motor1.*r_com_mid.*t4.*2.0;
t39 = dtheta_1.*l_top.*m_motor2.*r_com_mid.*t4.*2.0;
t40 = dtheta_2.*l_top.*m_motor1.*r_com_mid.*t4.*2.0;
t41 = dtheta_2.*l_top.*m_motor2.*r_com_mid.*t4.*2.0;
t62 = t18+t19+t20;
t14 = cos(t13);
t15 = sin(t13);
t16 = t8.*2.0;
t17 = t10.*2.0;
t21 = l_mid.*t9;
t22 = l_mid.*t11;
t28 = dtheta_2.*r_com_mid.*t9.*2.0;
t32 = dtheta_2.*r_com_mid.*t11.*2.0;
t46 = -t30;
t47 = -t33;
t48 = -t34;
t49 = -t35;
t50 = -t37;
t51 = -t40;
t52 = -t41;
t53 = dtheta_1.*l_top.*m_bot.*r_com_bot.*t12.*2.0;
t54 = dtheta_2.*l_top.*m_bot.*r_com_bot.*t12.*2.0;
t55 = dtheta_3.*l_top.*m_bot.*r_com_bot.*t12.*2.0;
t69 = r_com_mid.*t9.*t62.*2.0;
t70 = r_com_mid.*t11.*t62.*2.0;
t23 = r_com_bot.*t15;
t24 = t21.*2.0;
t25 = t22.*2.0;
t26 = r_com_bot.*t14;
t56 = -t53;
t57 = -t54;
t58 = -t55;
t27 = t23.*2.0;
t31 = t26.*2.0;
t44 = dtheta_3.*m_bot.*t26;
t45 = dtheta_3.*m_bot.*t23;
t60 = t21+t26;
t61 = t22+t23;
t42 = dtheta_3.*t31;
t43 = dtheta_3.*t27;
t59 = -t45;
t63 = t24+t31;
t64 = t25+t27;
t65 = dtheta_2.*t60.*2.0;
t66 = dtheta_2.*t61.*2.0;
t67 = (m_bot.*t63)./2.0;
t68 = (m_bot.*t64)./2.0;
t71 = t67+t69;
t72 = t68+t70;
t73 = dtheta_2.*t72;
t74 = dtheta_2.*t71;
t75 = -t73;
C = reshape([b1,0.0,0.0,0.0,0.0,0.0,b2,0.0,0.0,0.0,t59+t75-(m_bot.*(t43+t66+dtheta_1.*(t10+t61).*2.0))./2.0-t62.*(t32+dtheta_1.*(t10+r_com_mid.*t11).*2.0)-dtheta_1.*((m_bot.*(t17+t64))./2.0+t62.*(t17+r_com_mid.*t11.*2.0)+m_top.*r_com_top.*t3)-dtheta_1.*m_top.*r_com_top.*t3,t44+t74+(m_bot.*(t42+t65+dtheta_1.*(t8+t60).*2.0))./2.0+t62.*(t28+dtheta_1.*(t8+r_com_mid.*t9).*2.0)+dtheta_1.*((m_bot.*(t16+t63))./2.0+t62.*(t16+r_com_mid.*t9.*2.0)+m_top.*r_com_top.*t2)+dtheta_1.*m_top.*r_com_top.*t2,b3+t46+t49+t50+t51+t52+t57+t58,t29+t36+t38+t39+t49+t53,t33+t34+t53,t59+t75-dtheta_1.*t72-(m_bot.*(t43+t66+dtheta_1.*t61.*2.0))./2.0-t62.*(t32+dtheta_1.*r_com_mid.*t11.*2.0),t44+t74+dtheta_1.*t71+(m_bot.*(t42+t65+dtheta_1.*t60.*2.0))./2.0+t62.*(t28+dtheta_1.*r_com_mid.*t9.*2.0),-t29-t36-t38-t39+t46+t49+t50+t51+t52+t56+t57+t58,b4+t49,t33+t34,t59-(m_bot.*(t43+dtheta_1.*t27+dtheta_2.*t27))./2.0-dtheta_1.*m_bot.*t23-dtheta_2.*m_bot.*t23,t44+(m_bot.*(t42+dtheta_1.*t31+dtheta_2.*t31))./2.0+dtheta_1.*m_bot.*t26+dtheta_2.*m_bot.*t26,t47+t48+t49+t56+t57+t58,t47+t48+t49,b5],[5,5]);