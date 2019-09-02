function [mesh] = trimMesh(mesh,p)

%remove area of mesh using by changing numerical value to NaN 
%mesh= structured array containing faces and vertices
%p= percentage of mesh to remove from the top of the z axis.

%[fv1]=stlread('G:\ImplantProject\SSM(E)\5.Individual_aligned_teeth_stl_files\L.1\mean_L1_ref.stl');
%[fv2]=stlread('G:\ImplantProject\SSM(E)\5.Individual_aligned_teeth_stl_files\L.1\Aligned\WholeTooth\L.1.1.6_align_WT.stl');


fv1min=min(mesh.vertices(:,3));
fv1max=max(mesh.vertices(:,3));

range=fv1max-fv1min;

p=10;
x=p/100;
y=range*x;
val=fv1max-y;

for i=1:length(mesh.vertices);
    
    if mesh.vertices(i,3)>val;
        mesh.vertices(i,:)=NaN;
    end
    
end

final_plot(mesh,1)