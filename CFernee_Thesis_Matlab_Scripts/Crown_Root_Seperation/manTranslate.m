% Doesn't use fv1 at all
% it only changes fv2 (the target)
function [fv2_TT]=manTranslate(fv2,X,Y,Z)


f2=fv2.faces;
v2=fv2.vertices;

%Target Centroid
[GlobalCentroid_2]=mean(v2);

%Target 
%Reposition x component of vector array
v2(:,1)=[v2(:,1)+X];
%Reposition y component of vector array
v2(:,2)=[v2(:,2)+Y];
%Reposition z component of vector array
v2(:,3)=[v2(:,3)+Z];
%Create structured array containing faces and verticies
%fv2=struct('faces',f2,'vertices',v2);

fv2_TT.faces=f2;
fv2_TT.vertices=v2;