function [enamFace4]=areaFill(wholeTooth,enamFace3,p)
%Use to flood fill area of tooth to represent enamel. p is the percentage
%of the tooth (height from top of tooth) that is to be assigned as enamel.


maxZ=max(wholeTooth.vertices(:,3));
minZ=min(wholeTooth.vertices(:,3));
range=maxZ-minZ;
cutOff=maxZ-(range*(p/100));

enamVert=zeros(length(wholeTooth.vertices),1);

for i=1:length(wholeTooth.vertices)
    
    if wholeTooth.vertices(i,3)>cutOff
        
        enamVert(i)=1;
        
    end
    
end

enamFace4=enamFace3;

for i=1:length(enamFace4)

    check(i,1)=enamVert(wholeTooth.faces(i,1));
    check(i,2)=enamVert(wholeTooth.faces(i,2));
    check(i,3)=enamVert(wholeTooth.faces(i,3));
    
    if sum(check(i,:))==3
    
        enamFace4(i)=1;
        
    end
    
end

% figure (5)
% patch('faces',wholeTooth.faces,'vertices',wholeTooth.vertices,'FaceColor','flat','FaceVertexCData',enamFace4);
% title('Morphed Mesh, Baseline to Target');
% axis('image');
% view([1,0,0]);
