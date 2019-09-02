RegData=dir(RegDir);

for i=3:size(RegData,1)
    %%Calculate surface areas of each surface 
    
  
    
    [WholeToothMeshFilepath]=fullfile(RegDir,RegData(i).name,'whole_tooth.stl');
    %[WholeToothMeshFilepath]=fullfile(RegDir,RegData(i).name,'WholeToothRemesh.stl');
    [fWT,vWT,~] = stlread(WholeToothMeshFilepath);
    areaWT = 0;
    areaWT = meshSurfaceArea(vWT,fWT);
    
    [EnamelMeshFilepath]=fullfile(RegDir,RegData(i).name,'_3_Enamel.stl');
    %[EnamelMeshFilepath]=fullfile(RegDir,RegData(i).name,'EnamelRemesh.stl');
    [fEnam,vEnam,~] = stlread(EnamelMeshFilepath);
    areaEnam = 0;
    areaEnam = meshSurfaceArea(vEnam,fEnam);
    
    [DentinMeshFilepath]=fullfile(RegDir,RegData(i).name,'_2_Dentin.stl');
    %[DentinMeshFilepath]=fullfile(RegDir,RegData(i).name,'DentinRemesh.stl');
    [fDent,vDent,~] = stlread(DentinMeshFilepath);
    areaDent = 0;
    areaDent = meshSurfaceArea(vDent,fDent);
    
    %[DentinNoPulpMeshFilepath]=fullfile(RegDir,RegData(i).name,'_2_Dentin no pulp.stl');
    %[fDentNP,vDentNP,~] = stlread(DentinNoPulpMeshFilepath);
    %areaDentNP = 0;
    %areaDentNP = meshSurfaceArea(vDentNP,fDentNP);
    
    [PulpMeshFilepath]=fullfile(RegDir,RegData(i).name,'_1_Pulp.stl');
    [fPulp,vPulp,~] = stlread(PulpMeshFilepath);
    areaPulp = 0;
    areaPulp = meshSurfaceArea(vPulp,fPulp);
    
    [CrownMeshFilepath]=fullfile(RegDir,RegData(i).name,'Enamel_Shell.stl');
    [fCrown,vCrown,~] = stlread(CrownMeshFilepath);
    areaCrown = 0;
    areaCrown = meshSurfaceArea(vCrown,fCrown);
    
    [RootMeshFilepath]=fullfile(RegDir,RegData(i).name,'Root_Shell.stl');
    [fRoot,vRoot,~] = stlread(RootMeshFilepath);
    areaRoot = 0;
    areaRoot = meshSurfaceArea(vRoot,fRoot);
    
    
    % Calculate volume
    [WTMeshFilepath]=fullfile(RegDir,RegData(i).name,'whole_tooth.stl');
    %[WTMeshFilepath]=fullfile(RegDir,RegData(i).name,'WholeToothRemesh.stl');
    [fWTSol,vWTSol,~] = stlread(WTMeshFilepath);
    volWT = 0;
    volWT = meshVolume(vWTSol,fWTSol);
    
    [EnamelMeshFilepath]=fullfile(RegDir,RegData(i).name,'_3_Enamel.stl');
    %[EnamelMeshFilepath]=fullfile(RegDir,RegData(i).name,'EnamelRemesh.stl');
    [fEnamSol,vEnamSol,~] = stlread(EnamelMeshFilepath);
    volEnam = 0;
    volEnam = meshVolume(vEnamSol,fEnamSol);
    
    [DentinMeshFilepath]=fullfile(RegDir,RegData(i).name,'_2_Dentin.stl');
    %[DentinMeshFilepath]=fullfile(RegDir,RegData(i).name,'DentinRemesh.stl');
    [fDentSol,vDentSol,~] = stlread(DentinMeshFilepath);
    volDent = 0;
    volDent = meshVolume(vDentSol,fDentSol);
    
    [PulpMeshFilepath]=fullfile(RegDir,RegData(i).name,'_1_Pulp.stl');
    [fPulpSol,vPulpSol,~] = stlread(PulpMeshFilepath);
    volPulp = 0;
    volPulp = meshVolume(vPulpSol,fPulpSol);
    
    [CrownCapMeshFilepath]=fullfile(RegDir,RegData(i).name,'Crown_Cap.stl');
    [fCrownSol,vCrownSol,~] = stlread(CrownCapMeshFilepath);
    volCrown = 0;
    volCrown = meshVolume(vCrownSol,fCrownSol);
    
    ToothSAVolData(i,1)=areaWT;
    ToothSAVolData(i,2)=areaEnam;
    ToothSAVolData(i,3)=areaDent;
    ToothSAVolData(i,4)=areaCrown;
    ToothSAVolData(i,5)=areaPulp;
    ToothSAVolData(i,6)=areaRoot;
    ToothSAVolData(i,7)=volWT;
    ToothSAVolData(i,8)=volEnam;
    ToothSAVolData(i,9)=volDent;
    ToothSAVolData(i,10)=volDentNP;
    ToothSAVolData(i,11)=volPulp;
    ToothSAVolData(i,12)=volCrown;
    
    
    
end
    