function [centroid_1,centroid_2]=faceCentroid(fv1_T,fv2_T)

%Find Centroid of each facet
%Baseline
for i=1:1:size(fv1_T.faces,1);
x=i*3;
y=x-2;
centroid_1(i,1)=mean(fv1_T.vertices(y:x,1));
centroid_1(i,2)=mean(fv1_T.vertices(y:x,2));
centroid_1(i,3)=mean(fv1_T.vertices(y:x,3));
end
%Target
for i=1:1:size(fv2_T.faces,1);
x=i*3;
y=x-2;
centroid_2(i,1)=mean(fv2_T.vertices(y:x,1));
centroid_2(i,2)=mean(fv2_T.vertices(y:x,2));
centroid_2(i,3)=mean(fv2_T.vertices(y:x,3));
end