%% *Multivariate |S2FunHarmonic|*
% This site assumes you have read the documentation for univariate |S2FunHarmonic|, as we are not covering content which is already in there.
%
%% Structural conventions of the input and output of multivariate S2FunHarmonic
% * the structure of the nodes is always interpretes as a collumn vector
% * the node index is the first dimension
% * the dimensions of the S2FunHarmonic itself is counted from the second dimension
%
% For example you got four nodes $v_1, v_2, v_3$ and $v_4$ and six functions $f_1, f_2, f_3, f_4, f_5$ and $f_6$, which you want to store in a 3x2 array, then the following sheme applies to function evaluations:
%
% $$ F(:, :, 1) = \pmatrix{f_1(v_1) & f_2(v_1) & f_3(v_1) \cr f_1(v_2) & f_2(v_2) & f_3(v_2) \cr f_1(v_3) & f_2(v_3) & f_3(v_3) \cr f_1(v_4) & f_2(v_4) & f_3(v_4)} \quad\mathrm{and}\quad F(:, :, 2) = \pmatrix{f_4(v_1) & f_5(v_1) & f_6(v_1) \cr f_4(v_2) & f_5(v_2) & f_6(v_2) \cr f_4(v_3) & f_5(v_3) & f_6(v_3) \cr f_4(v_4) & f_5(v_4) & f_6(v_4)}. $$
%
% For the intern Fourier-coefficient matrix the first dimension is reseverd for for the Fourier-coefficients of a single function; the dimension of the functions itself begin again with the second dimension.
%
% If $\bf{\hat f}_1, \bf{\hat f}_2, \bf{\hat f}_3, \bf{\hat f}_4, \bf{\hat f}_5$ and $\bf{\hat f}_6$ would be the collumn vectors of the Fourier-coefficients of the functions above, internally they would be stored in $\hat F$ as follows.
% $$ \hat F(:, :, 1) = \pmatrix{\bf{\hat f}_1 & \bf{\hat f}_2 & \bf{\hat f}_3} \quad\mathrm{and}\quad \hat F(:, :, 2) = \pmatrix{\bf{\hat f}_4 & \bf{\hat f}_5 & \bf{\hat f}_6}. $$
%
%

%% Defining a multivariate S2FunHarmonic
%
%%
% *Definition via function values*
%
% At first we need some vertices
nodes = equispacedS2Grid('points', 1e5);
nodes = nodes(:);
%%
% Next we define function values for the vertices
y = [smiley(nodes), (nodes.x.*nodes.y).^(1/4)];
%%
% Now the actual command to get a 2x1 |sF1| of type |S2FunHarmonic|
sF1 = S2FunHarmonic.approximation(nodes, y)

%%
% *Definition via function handle*
%
% If we have a function handle for the function we could create a |S2FunHarmonic| via quadrature.
% At first lets define a function handle which takes <matlab:doc(vector3d) |vector3d|> as an argument and returns double:

f = @(v) [exp(v.x+v.y+v.z)+50*(v.y-cos(pi/3)).^3.*(v.y-cos(pi/3) > 0), v.x, v.y, v.z];
%% 
% Now we call the quadrature command to get 4x1 |sF2| of type |S2FunHarmonic|
sF2 = S2FunHarmonic.quadrature(f, 'bandwidth', 50)

%%
% *Definition via Fourier-coefficients*
%
% If you already know the Fourier-coefficients, you can simply hand them in the format above to the constructor of |S2FunHarmonic|.

sF3 = S2FunHarmonic(eye(9))

%%
% * This command stores the nine first spherical harmonics in |sF3|


%% Operations which differ from an univariate |S2FunHarmonic|
%
%%
% *Some default matrix and vector operations*
%
% You can cancatenate and refer to functions as matlab does with vectors and matrices

sF4 = [sF1; sF2];
sF4(2:3);

%%
% You can conjugate the Fourier-coefficients and transpose/ctranspose the multivariate |S2FunHarmonic|.

conj(sF1);
sF1.';
sF1';

%%
% Some other operations

length(sF1);
size(sF2);
sF3 = reshape(sF3, 3, []);

%%
% *min/max*
%
% If the |min| or |max| command gets a multivariate |S2FunHarmonic| the pointwise minimum or maximimum is calculated along the first non-singelton dimension if not specified otherwise.
%

min(sF3);

%%
% *Remark for matrix product*
%
% At this point the matrix product is implemented per element and not as the usual matrix product.



%% Visualization
% There are different ways to visualize a multivariate |S2FunHarmonic|
%
% The default |plot|-command
plot(sF1); 

%%
% * |plot(sF1)| is the same same as |contourf(sF1)|

%%
% nonfilled contour plot
contour(sF2, 'LineWidth', 2);

%%
% color plot without contours
pcolor(sF3);

%%
% 3D plot which you can rotate around
plot3d(sF2);

%%
% 3D plot where the radius of the sphere is transformed according to the function values
surf(sF3);

%%
% Plot the intersection of the surf plot with a plane with normal vector |v|
plotSection(sF1, zvector);

%%
% plotting the fourier coefficients
plotSpektra(sF2);
set(gca,'FontSize', 20);