%%
%Set Patrameters

%select Baseline Mesh
[baselineFileName, baselinePathName, filterIndex] = uigetfile('*.stl', 'Select Baseline Mesh');
[baselineFilePath] = fullfile(baselinePathName, baselineFileName);
[fv1] = stlread(fullfile(baselinePathName,baselineFileName));
[fv1, fv1]= translate(fv1, fv1);

%Select Folder Containing Aligned Target Meshes
[targetPathName] = uigetdir('', 'Select Folder Containing Alligned Meshes');
[data]=dir(fullfile(targetPathName,'*.stl'));

%Select location to save registered meshes
[RegDir] = uigetdir('', 'Select Folder to Save Registered Meshes');

%Select folder containing remeshed enamel meshes
[EnamDir]=uigetdir('', 'Select Folder Containing Remeshed Enamel Meshes');
EnamData=dir(fullfile(EnamDir,'*.stl'));


%%
%Batch Registration - Register whole tooth meshes

for i = 1:length(data);
    
    [filename] = data(i).name; %set filename to name of current file from data table
    
    [fv2] = stlread(fullfile(targetPathName,filename));
    
    %[fv2, fv2]= translate(fv2, fv2);
    
    [centroid1, centroid2] = faceCentroid(fv1, fv2);

    %overplot(fv1,fv2)%%%%%%%%%image output of alignment
    
    [W_2] = displacementMag4(centroid2, fv1, fv2, 30, 3); 
    %[handles.D1x, handles.rho] = displacementMag3(handles.centroid2, handles.fv1.vertices, handles.fv2.vertices, handles.fv2.faces, 50);
    %[handles.W_2] = morphedMesh(handles.D1x, handles.fv1.vertices, handles.fv1.faces);
    
    final_plot(W_2,i)
    
    [saveName] = ['reg_' data(i).name];
    [saveFilePath] = fullfile(RegDir, saveName);
    stlwrite(saveFilePath, W_2);

end


%%
%Map Enamel onto registered whole tooth and export root and mesh data.
RegData=dir(fullfile(RegDir,'*.stl'));

for i=1:1:size(RegData,1)

j=i+100; %large number used for figure

[RegFilepath]=fullfile(RegDir,RegData(i).name);
[EnamFilepath]=fullfile(EnamDir,EnamData(i).name);

%use k-d tree to find nearest neighbors of enamel on whole tooth dataset 
[wholeTooth]=stlread(RegFilepath);
[enamel]=stlread(EnamFilepath);

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
f=fullfile(RegDir,r);
save(f, 'enamFace4');

%Save enamel mesh
[enamelSurface]=meshExtract(wholeTooth,enamFace4);
r=strrep(a,'.stl','_EE.stl');
f=fullfile(RegDir,'ExtractedCrowns',r);
stlwrite(f,enamelSurface);

%Save dentin mesh
[dentFace]=1-enamFace4;
[dentSurface]=meshExtract(wholeTooth,dentFace);
r=strrep(a,'.stl','_ED.stl');
f=fullfile(RegDir,'ExtractedRoots',r);
stlwrite(f,dentSurface);

figure (j)
patch('faces',wholeTooth.faces,'vertices',wholeTooth.vertices,'FaceColor','flat','FaceVertexCData',enamFace4);
title('Morphed Mesh, Baseline to Target');
axis('image');
view([1,0,0]);

end

%%
%%Take measurements using extracted root + enamel meshes.
for i=1:size(RegData,1)
    
%Import enamel mesh
[EnamMeshData]=dir(fullfile(RegDir,'ExtractedCrowns','*.stl'));
[EnamMeshFilepath]=fullfile(RegDir,'ExtractedCrowns',EnamMeshData(i).name);
[Enamel] = stlread(EnamMeshFilepath);

%import dentin mesh
[DentMeshData]=dir(fullfile(RegDir,'ExtractedRoots','*.stl'));
[DentMeshFilepath]=fullfile(RegDir,'ExtractedRoots',DentMeshData(i).name);
[Dentin] = stlread(DentMeshFilepath);

[LOCla,LOCli,LORla,LORli,MDC,MDCc,LDC,LDCc,COCJmLi,COCJmLa,COCJdLi,COCJdLa]=measurements2(Dentin,Enamel);

ToothDims(i,1)=LOCla;
ToothDims(i,2)=LOCli;
ToothDims(i,3)=LORla;
ToothDims(i,4)=LORli;
ToothDims(i,5)=MDC;
ToothDims(i,6)=MDCc;
ToothDims(i,7)=LDC;
ToothDims(i,8)=LDCc;
ToothDims(i,9)=COCJmLi;
ToothDims(i,10)=COCJmLa;
ToothDims(i,11)=COCJdLi;
ToothDims(i,12)=COCJdLa;

end

