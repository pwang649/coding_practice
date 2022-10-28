function [V]=eval2DGrid(xGrid,yGrid,func)
%
% Description: Evaluate a function of two dimensional vectors on a grid.
% Usage: [V]=eval2DGrid(xGrid,yGrid,func)
%
%
nx=numel(xGrid);
ny=numel(yGrid);
X=ones(ny,1)*reshape(xGrid,1,nx);
Y=reshape(yGrid,ny,1)*ones(1,nx);
indVar=[reshape(X,1,nx*ny);reshape(Y,1,nx*ny)];
V=func(indVar);
V=reshape(V,ny,nx);
return
end