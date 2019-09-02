[RegDir] = uigetdir('', 'Select Folder Containing individual tooth directories');
RegData=dir(RegDir);

for i=4:size(RegData,1)
    
    [WTFilepath]=fullfile(RegDir,RegData(i).name,'WholeTooth_Remesh.stl');
    %[WTFilepath]=fullfile(RegDir,RegData(i).name,'whole_tooth.stl');
    [wholeTooth]=stlread(WTFilepath);
    
    %[DentinFilepath]=fullfile(RegDir,RegData(i).name,'Dentin_Remesh.stl');
    %[dentin]=stlread(DentinFilepath);
    
    [EnamFilepath]=fullfile(RegDir,RegData(i).name,'Enamel_Remesh.stl');
    %[EnamFilepath]=fullfile(RegDir,RegData(i).name,'_3_Enamel.stl');
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
    f=fullfile(RegDir,a,'enamList');
    save(f, 'enamFace4');

    %Save enamel mesh
    [enamelSurface]=meshExtract(wholeTooth,enamFace4);
    a=RegData(i).name;
    f=fullfile(RegDir,a,'Enamel_Shell.stl');
    stlwrite(f,enamelSurface);
    

    %Save dentin mesh
    [dentFace]=1-enamFace4;
    [dentSurface]=meshExtract(wholeTooth,dentFace);
    a=RegData(i).name;
    f=fullfile(RegDir,a,'Root_Shell.stl');
    stlwrite(f,dentSurface);
    
end
