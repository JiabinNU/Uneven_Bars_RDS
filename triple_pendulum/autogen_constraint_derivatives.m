function [A,H_x,H_y] = autogen_constraint_derivatives(dx,dy)
%AUTOGEN_CONSTRAINT_DERIVATIVES
%    [A,H_X,H_Y] = AUTOGEN_CONSTRAINT_DERIVATIVES(DX,DY)

%    This function was generated by the Symbolic Math Toolbox version 8.3.
%    07-May-2020 14:29:03

A = [dx;dy];
if nargout > 1
    H_x = reshape([0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0],[5,5]);
end
if nargout > 2
    H_y = reshape([0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0],[5,5]);
end