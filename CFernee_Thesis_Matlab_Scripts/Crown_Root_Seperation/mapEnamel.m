function [enamFace,idx]=mapEnamel(wholeTooth,enamel,range)
%map enamel mesh onto whole tooth mesh. meshes must be fully alligned to be
%effective. Range is number of near neighbours to find (usually 1 or 2)
%Output is list of faces that make up the enamel of the whole
%tooth.


for i=1:1:size(wholeTooth.faces,1);
x=i*3;
y=x-2;
centroid_1(i,1)=mean(wholeTooth.vertices(y:x,1));
centroid_1(i,2)=mean(wholeTooth.vertices(y:x,2));
centroid_1(i,3)=mean(wholeTooth.vertices(y:x,3));
end

[idx]=knnsearch(centroid_1,enamel.vertices,'k',range);
enamFace=zeros(size(wholeTooth.faces,1),1);

for i=1:length(idx)
    enamFace(idx(i,1),1)=1;
    %enamFace(idx(i,2),1)=1;
end

% figure (2)
% patch('faces',wholeTooth.faces,'vertices',wholeTooth.vertices,'FaceColor','flat','FaceVertexCData',enamFace);
% title('Morphed Mesh, Baseline to Target');
% axis('image');
% view([1,0,0]);