function [fv1_T,fv2_T]=translate(fv1,fv2)

f1=fv1.faces;
v1=fv1.vertices;
f2=fv2.faces;
v2=fv2.vertices;

% Find Centroid 
%Baseline Centroid
[GlobalCentroid_1]=mean(v1);
%Target Centroid
[GlobalCentroid_2]=mean(v2);

%Reposition .stl files
%Baseline 
%Reposition x component of vector array
v1(:,1)=[v1(:,1)-GlobalCentroid_1(1,1)];
%Reposition y component of vector array
v1(:,2)=[v1(:,2)-GlobalCentroid_1(1,2)];
%Reposition z component of vector array
v1(:,3)=[v1(:,3)-GlobalCentroid_1(1,3)];
%Create structured array containing faces and verticies
%fv1=struct('faces',f1,'vertices',v1);
clear GlobalCentroid_1;
% 
%Target 
%Reposition x component of vector array
v2(:,1)=[v2(:,1)-GlobalCentroid_2(1,1)];
%Reposition y component of vector array
v2(:,2)=[v2(:,2)-GlobalCentroid_2(1,2)];
%Reposition z component of vector array
v2(:,3)=[v2(:,3)-GlobalCentroid_2(1,3)];
%Create structured array containing faces and verticies
%fv2=struct('faces',f2,'vertices',v2);
clear GlobalCentroid_2;

fv1_T.faces=f1;
fv1_T.vertices=v1;
fv2_T.faces=f2;
fv2_T.vertices=v2;