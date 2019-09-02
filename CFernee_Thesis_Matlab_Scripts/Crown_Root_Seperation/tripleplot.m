% tripleplot plots 3 different views of the .stl files within the GUI
function tripleplot(fv1, fv2, handles)

%% TRYING SOMETHING HERE
% Lets see if we can plot the 3D stuff in the axis box
f1=fv1.faces;
v1=fv1.vertices;
f2=fv2.faces;
v2=fv2.vertices;

%Front view
%Baseline
axes(handles.axes1);
cla
patch('faces',f1,'vertices',v1,'FaceColor',[0.8 0.8 1.0],'EdgeColor',[0.8 0.3 1.0],'FaceLighting','gouraud','AmbientStrength', 0.15);
camlight('headlight');
material('dull');
axis('image');
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Front (me)')
view([-0,-0,2.5]);
%Target
patch('faces',f2,'vertices',v2,'FaceColor',[0.8 0.8 1.0],'EdgeColor',[0.2 0.8 1.0],'FaceLighting','gouraud','AmbientStrength', 0.15);
camlight('headlight');
material('dull');
axis('image');
view([-0,-0,2.5]);

%Side View
%Baseline 
axes(handles.axes2)
cla
patch('faces',f1,'vertices',v1,'FaceColor',[0.8 0.8 1.0],'EdgeColor',[0.8 0.3 1.0],'FaceLighting','gouraud','AmbientStrength', 0.15);
camlight('headlight');
material('dull');
axis('image');
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Side')
view([-2.5,-0,0]);
%Target
patch('faces',f2,'vertices',v2,'FaceColor',[0.8 0.8 1.0],'EdgeColor',[0.2 0.8 1.0],'FaceLighting','gouraud','AmbientStrength', 0.15);
camlight('headlight');
material('dull');
axis('image');
view([-2.5,-0,0]);

%Top View
%Baseline 
axes(handles.axes3)
cla
patch('faces',f1,'vertices',v1,'FaceColor',[0.8 0.8 1.0],'EdgeColor',[0.8 0.3 1.0],'FaceLighting','gouraud','AmbientStrength', 0.15);
camlight('headlight');
material('dull');
axis('image');
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Top')
view([0,-2.5,0]);
%Target
patch('faces',f2,'vertices',v2,'FaceColor',[0.8 0.8 1.0],'EdgeColor',[0.2 0.8 1.0],'FaceLighting','gouraud','AmbientStrength', 0.15);
camlight('headlight');
material('dull');
axis('image');
view([0,-2.5,0]);

