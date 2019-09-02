function [newSurface]=meshExtract(wholeTooth,enamFace4)

faces=find(enamFace4);

for i=1:length(faces)
   
   newSurface.faces(i,:)=wholeTooth.faces(i,:);
   
   faceRow=faces(i);
   vecRow=wholeTooth.faces(faceRow,:);
   
   j=(i*3)-2;
   newSurface.vertices(j,:)=wholeTooth.vertices(vecRow(1),:);
   newSurface.vertices((j+1),:)=wholeTooth.vertices(vecRow(2),:);
   newSurface.vertices((j+2),:)=wholeTooth.vertices(vecRow(3),:);
   
end 

%final_plot(enamelSurface,1)
