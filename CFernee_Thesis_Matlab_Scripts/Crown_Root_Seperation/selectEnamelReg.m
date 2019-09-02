for x=1:1:3
    
y=num2str(x);
filepath=(['G:\ImplantProject\SSM(E)\5.Individual_aligned_teeth_stl_files\U.1\U.1.2.',y,'\Remesh']);

%[wholeTooth]=stlread('G:\ImplantProject\SSM(E)\5.Individual_aligned_teeth_stl_files\U.1\U.1.1.2\Remesh\WholeToothRemesh.stl');
%[enamel]=stlread('G:\ImplantProject\SSM(E)\5.Individual_aligned_teeth_stl_files\U.1\U.1.1.2\Remesh\EnamelShell.stl');

%use k-d tree to find nearest neighbors of enamel on whole tooth dataset 
[enamel]=stlread([filepath '\EnamelRemesh.stl']);
[wholeTooth]=stlread([filepath '\WholeToothRemesh.stl']);

%initial enamel map
[enamFace,idx]=mapEnamel(wholeTooth,enamel,1);

%Fill holes and reduce jaggedness of enamel
[enamFace2]= fillGaps(wholeTooth,idx);

%Reduce jaggedness of dentin
[enamFace3]= fillGapsDent(wholeTooth,enamFace2);

%Fill area in enamel based on percentage height from top of 
[enamFace4]=areaFill(wholeTooth,enamFace3,20);

%Save enamel List as .mat file
save([filepath '\EnamelList.mat'], 'enamFace4');

figure (x)
patch('faces',wholeTooth.faces,'vertices',wholeTooth.vertices,'FaceColor','flat','FaceVertexCData',enamFace4);
title('Morphed Mesh, Baseline to Target');
axis('image');
view([1,0,0]);


clear all

end


%Create enamel mesh i.e. vertices and faces.
[enamelSurface]=meshExtract(wholeTooth,enamFace4);
%save enamel mesh (.STL)
stlwrite('G:\ImplantProject\SSM(E)\5.Individual_aligned_teeth_stl_files\U.1\U.1.1.2\Remesh\EnamelShell.stl',enamelSurface);


%%
final_plot(wholeTooth,1)

overplot(wholeTooth,enamel);

