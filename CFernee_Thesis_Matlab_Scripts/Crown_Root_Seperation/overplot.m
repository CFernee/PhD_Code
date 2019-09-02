function overplot(mesh1,mesh2)

figure(5)
%subplot(3,4,[1 5 9]);
patch('faces',mesh1.faces,'vertices',mesh1.vertices,'FaceColor',[0 0 1],'EdgeColor',[0 0 1],'FaceLighting','gouraud','AmbientStrength', 0.15);
title('Morphed Mesh, Baseline to Target');
camlight('headlight');
material('dull');
axis('image');
view([1,0,0]);
hold on

%subplot(3,4,[1 5 9]);
patch('faces',mesh2.faces,'vertices',mesh2.vertices,'FaceColor',[0 1 0],'EdgeColor',[0 1 0],'FaceLighting','gouraud','AmbientStrength', 0.15);
title('Morphed Mesh, Baseline to Target');
camlight('headlight');
material('dull');
axis('image');
view([1,0,0]);