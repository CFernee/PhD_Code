function [scaledMesh] = meshScale(mesh,x,y,z)

mesh.vertices(:,1)=mesh.vertices(:,1)*x;
mesh.vertices(:,2)=mesh.vertices(:,2)*y;
mesh.vertices(:,3)=mesh.vertices(:,3)*z;

