%% constraint_forces_uneven

% outputs: Fseg = a 2xlength(tseg) array of constraint forces

function [Fseg] = constraint_forces_uneven(tseg, xseg, params)

Fseg = zeros(2,length(tseg));

for i=1:length(tseg)
    t = tseg(i);
    x = xseg(:,i);
    q_dot = x(6:10);
    
    nq = numel(x)/2; % assuming x = [q, dq]
    q = x(1:nq);
    q_dot = x(nq+1: 2*nq);
    
    % solve for control inputs at this instant
    % no controls at this instant
    Q = [0; 0; 0; 0; 0];
    
    % finding parts that don't depend on constraint forces
    H = H_eom(x, params);
    M = mass_matrix_uneven(x, params);
    Minv = inv(M);
    [A_all, Hessian] = constraint_derivatives(x, params);
    
    % build the constraints and forces
    switch params.sim.constraints 
        % the robot is off the bar
        case ['false', 'false']
            Fseg(:,i) = zeros(2,0);
            
        % the robot is on the bar
        case ['true', 'true',] 
            A = A_all([1,2],:);
            Adotqdot = [q_dot'*Hessian(:,:,1)*q_dot;
                        q_dot'*Hessian(:,:,2)*q_dot];
            F = inv(A*Minv*A')*(A*Minv*(Q - H) + Adotqdot);
            Fseg(:,i) = [F(1); F(2)];
    end
end
end