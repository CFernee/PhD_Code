

[enamList]=find(mesh.vertices(:,4));

CEJ=zeros(size(mesh.vertices(:,1)));

for i=1:size(enamList,1)

    sameVert=find(mesh.vertices(enamList(i),1)==mesh.vertices(:,1));
    
        for j=1:length(sameVert)
                
            [r,~,~]=find(mesh.faces==sameVert(j,1));
            
            faceNodes(1,:)=mesh.faces(r,:);
            
            for k=1:1:3
            
            enamID=mesh.vertices(faceNodes(1,k),4);
                  
                if enamID==0
                    
                    CEJ(i,1)=1;
                    
                end
                
            end
            
        end
    
end

[perim]=find(CEJ);

for i=1:size(perim,1)

    CEJVecs(i,:)=mesh.vertices(enamList(perim(i)),1:3);
    
end

x=CEJVecs(:,1);
y=CEJVecs(:,2);
z=CEJVecs(:,3);
scatter3(x,y,z)
