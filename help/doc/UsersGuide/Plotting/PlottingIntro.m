%% Plotting Overview
% Overview over the plotting faccilities of MTEX, including annotations,
% plot types, color coding, combined plots and export of plots.
%
%% Open in Editor
%
%% Contents
%
%% Plotting in MTEX
%
% In MTEX you can plot almost any type data. Simply apply the *plot*
% command to any variable and MTEX tries to plot the content of the
% variable in the most intuive way. In this way you can plot three
% Miller indeces, rotations, pole figures, or ODFs. MTEX also offers you
% a wide range of possibilities to custumize your plots, e.g. by changing
% the <PlotTypes_demo.html plot style>, the
% <SphericalProjection_demo.html spherical projection>, the
% <ColorCoding_demo.html color coding>, or by adding
% <Annotations_demo.html colorbars or other annotations> to the plot. You
% can even <CombinedPlots_demo.html combine plots> of different ODFs or
% EBSD data. This way MTEX allows you to create publication ready plots
% which can be exported to almost any format using the commands
% <savefigure.html savefigure>.
%
%% Plot Types
%
% In general MTEX knows the following <PlotTypes_demo.html plot types>
%
% * contour plots
% * filled contour plots
% * smoots plots
% * scatter plots
% * line plots
%
% Contour plots are plots consisting only of contour lines and mainly used
% for pole figure or ODF plots. For raw pole figure data MTEX uses by
% default a plot where each datapoint is represented by a single dot colored
% accordingly to the intensity. Line plots are used by MTEX for one
% dimesional ODF plots, plots of Fourier coefficients and plots of kernel
% functions functions

%% Spherical Projections
% Whenever MTEX plots pole figures, ODFs, or crystal or specimen directions
% MTEX uses spherical projections to map the spherical data to the plane. By
% doing so MTEX supports a wide varity of <SphericalProjection_demo.html
% spherical projections>, i.e.,
%
% * equal area projection (Schmidt)
% * equal distance projection
% * equal angle projection (stereographic)
% * plain
% * 3d plots
%
%% Color Coding
% A central issue when interpreting plots is to have a consistent
% <ColorCoding_demo.html color coding> among all plots. In MTEX this can be
% achieved in two ways. If the the minimum and maximum value is known then
% one can use one of the following syntaxes to have a consistent color
% coding.
%
% * Specifying the colorrange
% * Setting a logarithmic color scale
% * Switching to a monochrome color scale
% *
% See also <ColorCodingEBSD_demo color coding EBSD>.
%
%% Plot Annotations
%
% After generating a plot with MTEX it is possible to modify it
% interactivly using the MATLAB plotting tools in the plotting figure. This
% includes
%
% * adding a colorbar
% * adding a legend
% * adding annotations
% * resizing / shifting parts of the plot
%
% This is described in more detail <Annotations_demo.html here.>
%
%% Combined Plots
%
% Sometimes it is usefull to combine several plots, e.g. plotting on the
% top of an inverse pole figure some important crystall directions. This
% can be performed by the command [[matlab:doc hold,hold all]],
% which preserfes MATLAB from replacing the old plot by the new one. This
% technique is described in more detail <CombinedPlots_demo.html here.>
%
%% Exporting Plots
%
% Plots generated by MTEX can be exported to a wide range of formats using
% the MATLAB function *save as* in the figure menu or using the command
% <savefigure.html savefigure>
%
