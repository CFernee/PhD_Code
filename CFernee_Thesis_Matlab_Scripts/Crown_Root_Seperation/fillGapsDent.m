function [enamFace3]= fillGapsDent(wholeTooth,enamFace2)
%use to patch up registration of enamel mesh to the whole tooth mesh.
%returns new list of faces for enamel material. 

dentFaces=enamFace2~=1;

dentVert=zeros(length(wholeTooth.vertices),1);

dentFaceVals=find(dentFaces);


for i=1:length(dentFaceVals)
    vertSet=wholeTooth.faces(dentFaceVals(i),:);
    dentVert(vertSet(1,1),1)=1;
    dentVert(vertSet(1,2),1)=1;
    dentVert(vertSet(1,3),1)=1;
end
    

for i=1:length(dentVert)
    
    if dentVert(i)==1
        
        sameVert=find(wholeTooth.vertices(:,1)==wholeTooth.vertices(i,1));
                      
        for j=1:length(sameVert)
                dentVert(sameVert(j),1)=1;
        end
        
    end

end


dentFace2=zeros(size(wholeTooth.faces,1),1);

for i=1:length(dentFace2)

    check(i,1)=dentVert(wholeTooth.faces(i,1));
    check(i,2)=dentVert(wholeTooth.faces(i,2));
    check(i,3)=dentVert(wholeTooth.faces(i,3));
    
    if sum(check(i,:))==3
    
        dentFace2(i)=1;
        
    end
    
end
    
enamFace3=dentFace2~=1;
enamFace3=enamFace3+0;

% figure (4)
% patch('faces',wholeTooth.faces,'vertices',wholeTooth.vertices,'FaceColor','flat','FaceVertexCData',enamFace3);
% title('Morphed Mesh, Baseline to Target');
% axis('image');
% view([1,0,0]);