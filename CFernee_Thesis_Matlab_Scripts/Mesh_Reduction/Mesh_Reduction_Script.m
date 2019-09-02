%Script for downsampling mesh of tooth files. 
%For enamel, dentin, whole tooth and whole tooth no pulp masks. 

%Select folder containing subfolders 
[RegDir] = uigetdir('', 'Select Folder Containing individual tooth directories');
RegData=dir(RegDir);

for i=4:size(RegData,1)
    
    [EnamMeshFilepath]=fullfile(RegDir,RegData(i).name,'_1_Enamel.stl');
    [Enamel] = stlread(EnamMeshFilepath);
    
    %[DentNoPulpMeshFilepath]=fullfile(RegDir,RegData(i).name,'DentinNoPulp.stl');
    %[DentinNoPulp] = stlread(DentNoPulpMeshFilepath);
    
    [DentMeshFilepath]=fullfile(RegDir,RegData(i).name,'_2_Dentin_no_pulp.stl');
    [Dentin] = stlread(DentMeshFilepath);
    
    %[PulpMeshFilepath]=fullfile(RegDir,RegData(i).name,'_1_Pulp.stl');
    %[Pulp] = stlread(PulpMeshFilepath);
    
    %[WholeToothMeshFilepath]=fullfile(RegDir,RegData(i).name,'whole_tooth.stl');
    %[WholeTooth] = stlread(WholeToothMeshFilepath);
    
    %[WholeToothWPulpMeshFilepath]=fullfile(RegDir,RegData(i).name,'WholeToothWPulp.stl');
    %[WholeToothWPulp] = stlread(WholeToothWPulpMeshFilepath);
    
    %Reduce number of faces use reducepatch(p,r) function
    %Reduce number of faces to a % of original number when r <1
    %Reduce number of faces to a set number when r>1
    %[mF,mV] = reducepatch(F,V,0.5)
    
    [EnamelRemesh] = reducepatch(Enamel,0.25);
    %[EnamelRemesh2] = reducepatch(EnamelRemesh,0.25);
    
    %[DentinNoPulpRemesh] = reducepatch(DentinNoPulp,0.5);
    %[DentinNoPulpRemesh2] = reducepatch(DentinNoPulpRemesh,0.25);

    [DentinRemesh] = reducepatch(Dentin,0.25);
    %[DentinRemesh2] = reducepatch(DentinRemesh,0.25);
   
    %[PulpRemesh] = reducepatch(Pulp,0.5);
    %[PulpRemesh2] = reducepatch(PulpRemesh,0.25);

    %[WholeToothRemesh] = reducepatch(WholeTooth,0.25);
    %[WholeToothRemesh2] =  reducepatch(WholeToothRemesh,0.25);

    %[WholeToothWPulpRemesh] = reducepatch(WholeToothWPulp,0.5);
    %[WholeToothWPulpRemesh2] = reducepatch(WholeToothWPulpRemesh,0.25);
    
    
    %Save Meshes 
    %Save Enamel Mesh
    f=fullfile(RegDir,RegData(i).name,'Enamel_Remesh.stl');
    stlwrite(f,EnamelRemesh);
    
    %Save Dentin No Pulp Mesh
    %f=fullfile(RegDir,RegData(i).name,'DentinNopulp_Remesh.stl');
    %stlwrite(f,DentinNoPulpRemesh2);
    
    
    %Save Dentin Mesh
    f=fullfile(RegDir,RegData(i).name,'Dentin_Remesh.stl');
    stlwrite(f,DentinRemesh);
    
    %Save Pulp Mesh 
    %f=fullfile(RegDir,RegData(i).name,'Pulp_Remesh.stl');
    %stlwrite(f,PulpRemesh);
    
    %Save Whole Tooth mesh 
    %f=fullfile(RegDir,RegData(i).name,'WholeTooth_Remesh.stl');
    %stlwrite(f,WholeToothRemesh);
    
    
    %Save Whole Tooth With Pulp mesh 
    %f=fullfile(RegDir,RegData(i).name,'WholeToothWPulp_Remesh.stl');
    %stlwrite(f,WholeToothWPulpRemesh2); 
end
