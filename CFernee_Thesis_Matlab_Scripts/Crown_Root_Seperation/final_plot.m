function final_plot(mesh, figureNo)
% mesh must have mesh.vertices and mesh.faces
% figureNo is a unique number used to identify the plot

%Plot
%Morphed Mesh, Baseline to Target
figure(figureNo)
subplot(3,4,[1 5 9]);
patch('faces',mesh.faces,'vertices',mesh.vertices,'FaceColor',[0.8 0.8 1.0],'EdgeColor',[0.2 0.8 1.0],'FaceLighting','gouraud','AmbientStrength', 0.15);
title('Morphed Mesh, Baseline to Target');
camlight('headlight');
material('dull');
axis('image');
view([1,0,0]);

subplot(3,4,[2 6 10]);
patch('faces',mesh.faces,'vertices',mesh.vertices,'FaceColor',[0.8 0.8 1.0],'EdgeColor',[0.2 0.8 1.0],'FaceLighting','gouraud','AmbientStrength', 0.15);
camlight('headlight');
material('dull');
axis('image');
view([-1,0,0]);

subplot(3,4,[3 4]);
patch('faces',mesh.faces,'vertices',mesh.vertices,'FaceColor',[0.8 0.8 1.0],'EdgeColor',[0.2 0.8 1.0],'FaceLighting','gouraud','AmbientStrength', 0.15);
title('Side');
camlight('headlight');
material('dull');
axis('image');
view([0,0,1]);

subplot(3,4,[7 8]);
patch('faces',mesh.faces,'vertices',mesh.vertices,'FaceColor',[0.8 0.8 1.0],'EdgeColor',[0.2 0.8 1.0],'FaceLighting','gouraud','AmbientStrength', 0.15);
camlight('headlight');
material('dull');
axis('image');
view([0,0,-1]);

subplot(3,4,11);
patch('faces',mesh.faces,'vertices',mesh.vertices,'FaceColor',[0.8 0.8 1.0],'EdgeColor',[0.2 0.8 1.0],'FaceLighting','gouraud','AmbientStrength', 0.15);
title('Plan');
camlight('headlight');
material('dull');
axis('image');
view([0,1,0]);

subplot(3,4,12);
patch('faces',mesh.faces,'vertices',mesh.vertices,'FaceColor',[0.8 0.8 1.0],'EdgeColor',[0.2 0.8 1.0],'FaceLighting','gouraud','AmbientStrength', 0.15);
camlight('headlight');
material('dull');
axis('image');
view([0,-1,0]);