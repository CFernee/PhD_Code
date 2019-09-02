%Measurements

[testMesh]=stlread('G:\ImplantProject\SSM(E)\5.Individual_aligned_teeth_stl_files\U.1\Aligned\Registered\reg_U.1.1.1_align_WT.stl');
load('G:\ImplantProject\SSM(E)\5.Individual_aligned_teeth_stl_files\U.1\Aligned\Registered\reg_U.1.1.1_align_WT_EL.mat');
[mesh]=testMesh;

%Add enamel column to vertices data from face data. 
    for j=1:size(mesh.faces,1)

        if enamFace4(j)==1
            [enamNodes]=mesh.faces(j,:);
            mesh.vertices(enamNodes(1),4)=1;
            mesh.vertices(enamNodes(2),4)=1;
            mesh.vertices(enamNodes(3),4)=1;

        end
    
    end
    
%Describe enamel mesh
enamelMeshFull=mesh;
for i=1:size(enamelMeshFull.vertices(:,1),1);

    if enamelMeshFull.vertices(i,4)==0;
        enamelMeshFull.vertices(i,:)=NaN;
    end
    
end
%Extract first 3 columns to capture only enamel coordinate information
[enamelMesh.vertices]=enamelMeshFull.vertices(:,1:3);
[enamelMesh.faces]=enamelMeshFull.faces;


%Describe dentin mesh
dentMeshFull=mesh;
for i=1:size(dentMeshFull.vertices(:,1),1);

    if dentMeshFull.vertices(i,4)==1;        
        dentMeshFull.vertices(i,:)=NaN;
    end
    
end
%Extract first 3 columns to capture only dentin coordinate information
[dentMesh.vertices]=dentMeshFull.vertices(:,1:3);
[dentMesh.faces]=dentMeshFull.faces;

%Describe CEJ from dentin information 




figure (1)
patch('faces',mesh.faces,'vertices',mesh.vertices,'FaceColor','flat','FaceVertexCData',enamFace4);
title('Morphed Mesh, Baseline to Target');
axis('image');
view([1,0,0]);

figure (2)
patch('faces',enamelMesh.faces,'vertices',enamelMesh.vertices,'FaceColor','r');
title('Enamel');
axis('image');
view([1,0,0]);

figure (3)
patch('faces',dentMesh.faces,'vertices',dentMesh.vertices,'FaceColor','r');
title('Enamel');
axis('image');
view([1,0,0]);