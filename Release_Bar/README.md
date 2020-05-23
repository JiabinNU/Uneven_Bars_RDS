# Triple Pendulum release Bar:
## Instruction:
1. run main_releasebar.m directly. 
2. The parameters are stored in init_params.m. The initialize parameters is in line 60-70. The bar position is in line 77-84.
3. derive_equations_releasebar.m is the m file constructing model. the generalized coordinates are in line 19. There are five variables: x_top y_top theta_1 theta_2 theta_3;
4. in derive_equations_releasebar.m inverse M and derive temp_ctrl and temp_drift cost too much time, about 8 hours. So I store the matrix in saveMiv.mat, savetemp_ctrl.mat, savetemp_drift.mat. 

