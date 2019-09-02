[RegDir]=uigetdir('', 'Select Folder Containing Registered Whole Tooth Meshes');
RegData=dir(fullfile(RegDir,'*.stl'));

[EnamDir]=uigetdir('', 'Select Folder Containing Remeshed Enamel Meshes');
EnamData=dir(fullfile(EnamDir,'*.stl'));

for i=1:1:size(RegData,1)
 %i=8
[RegFilepath]=fullfile(RegDir,RegData(i).name);
[EnamFilepath]=fullfile(EnamDir,EnamData(i).name);

%use k-d tree to find nearest neighbors of enamel on whole tooth dataset 
[wholeTooth]=stlread(RegFilepath);
[enamel]=stlread(EnamFilepath);

%[wholeToothSmooth2]=lp_smooth(wholeTooth,2);

%initial enamel map
[enamFace,idx]=mapEnamel(wholeTooth,enamel,1);

%Fill holes and reduce jaggedness of enamel
[enamFace2]= fillGaps(wholeTooth,idx);

%Reduce jaggedness of dentin
[enamFace3]= fillGapsDent(wholeTooth,enamFace2);

%Fill area in enamel based on percentage height from top of 
[enamFace4]=areaFill(wholeTooth,enamFace3,15);

%Save enamel List as .mat file
a=RegData(i).name;
r=strrep(a,'.stl','_EL.mat');
f=fullfile(RegDir,r)
save(f, 'enamFace4');

%Save enamel mesh
[enamelSurface]=meshExtract(wholeTooth,enamFace4);
r=strrep(a,'.stl','_EE.stl');
f=fullfile(RegDir,'ExtractedCrowns',r);
stlwrite(f,enamelSurface);

figure (i)
patch('faces',wholeTooth.faces,'vertices',wholeTooth.vertices,'FaceColor','flat','FaceVertexCData',enamFace4);
title('Morphed Mesh, Baseline to Target');
axis('image');
view([1,0,0]);

% figure (4)
% patch('faces',wholeToothSmooth2.faces,'vertices',wholeToothSmooth2.vertices,'FaceColor','flat','FaceVertexCData',enamFace4);
% title('Morphed Mesh, Baseline to Target');
% axis('image');
% view([1,0,0]);

%clear all

end

%%
%final_plot(enamelSurface,1)

overplot(wholeTooth,enamel);

