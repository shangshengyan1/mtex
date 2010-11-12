function E = shearModulus(C,h,u)
% shear modulus for an elasticity tensor
%
%% Description
%
% formula: G = 1/(4 S_ijkl h_i u_j h_k u_l)
%
%% Input
%  C - elastic stiffness @tensor
%  h - shear plane @vector3d
%  u - shear direction @vector3d
%
%% Output
%  E - shear modulus
%
%% See also

% compute the compliance tensor
S = inv(C);

% compute quadric
E = 0.25./EinsteinSum(S,[-1 -2 -3 -4],h,-1,u,-2,h,-3,u,-4);