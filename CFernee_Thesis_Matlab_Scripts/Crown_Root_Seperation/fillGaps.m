function [enamFace2]= fillGaps(wholeTooth,idx)
%use to patch up registration of enamel mesh to the whole tooth mesh.
%returns new list of faces for enamel material. 


enamVert=zeros(length(wholeTooth.vertices),1);
idxcol=reshape(idx,[],1);
enamFaceInd=unique(idxcol);

for i=1:length(enamFaceInd)
    vertSet=wholeTooth.faces(enamFaceInd(i),:);
    enamVert(vertSet(1,1),1)=1;
    enamVert(vertSet(1,2),1)=1;
    enamVert(vertSet(1,3),1)=1;
end
    

for i=1:length(enamVert)
    
    if enamVert(i)==1
        
        sameVert=find(wholeTooth.vertices(:,1)==wholeTooth.vertices(i,1));
                      
        for j=1:length(sameVert)
                enamVert(sameVert(j),1)=1;
        end
        
    end

end


enamFace2=zeros(size(wholeTooth.faces,1),1);

for i=1:length(enamFace2)

    check(i,1)=enamVert(wholeTooth.faces(i,1));
    check(i,2)=enamVert(wholeTooth.faces(i,2));
    check(i,3)=enamVert(wholeTooth.faces(i,3));
    
    if sum(check(i,:))==3
    
        enamFace2(i)=1;
        
    end
    
end
    


% figure (3)
% patch('faces',wholeTooth.faces,'vertices',wholeTooth.vertices,'FaceColor','flat','FaceVertexCData',enamFace2);
% title('Morphed Mesh, Baseline to Target');
% axis('image');
% view([1,0,0]);
