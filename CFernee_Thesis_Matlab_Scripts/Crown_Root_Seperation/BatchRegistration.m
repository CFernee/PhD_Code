targetPathName = uigetdir('', 'Select Folder Containing Alligned Meshes');

data=dir(fullfile(targetPathName,'*.stl'));

regPathName = uigetdir('', 'Select Folder to Save Registered Meshes');

[baselineFileName, baselinePathName, filterIndex] = uigetfile('*.stl', 'Select Baseline Mesh');

[handles.fv1] = stlread(fullfile(baselinePathName,baselineFileName));

for i = 1:length(data)
    
    filename = data(i).name; 
    
    [handles.fv2] = stlread(fullfile(targetPathName,filename));
    
    [handles.centroid1, handles.centroid2] = faceCentroid(handles.fv1, handles.fv2);

    [handles.D1x] = displacement(handles.centroid2, handles.fv1.vertices, handles.fv2.vertices, handles.fv2.faces, 50);
    
    [handles.W_2] = morphedMesh(handles.D1x, handles.fv1.vertices, handles.fv1.faces);
    
    saveName = ['reg_' baselineFileName 'to_' data(i).name];
    saveFilePath = fullfile(regPathName, saveName);
    stlwrite(handles.saveFilePath, handles.W_2);

end