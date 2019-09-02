function [smoothedMesh] = lp_smooth(mesh,iterations)

%Written by Christopher Woods.

%mesh input file must have sub-arrays with the following denominations;
%               mesh.faces
%               mesh.vertices

% Set a wait bar
h=waitbar(0, 'Smoothing...', 'CreateCancelBtn', 'setappdata(gcbf, ''cancelling'',1)');
set(h,'windowstyle','modal');
vSize = size((mesh.vertices(:,1)),1);

%initialise a matrix of zeros for memory allocation, to speed up
%computation
smoothedData = zeros(vSize,3);

for l=1:iterations
    
for i=1:1:vSize
    % Check for if user has pressed the cancel button on the wait window
    if getappdata(h, 'cancelling');
        break
    end
   
    %find all rows in vertices array that have the same coordinates i.e. share
    %a point  
    rows=find(mesh.vertices(:,1)==mesh.vertices(i,1));    
    rows1=find(mesh.vertices(rows(:,1),2)==mesh.vertices(i,2)); 
    rows=rows(rows1,1);
    rows2=find(mesh.vertices(rows(:,1),3)==mesh.vertices(i,3)); 
    rows=rows(rows2,1);
    
  
    %initialise a matrix of zeros for memory allocation, to speed up
    %computation
    meanNeigh = zeros(size((rows(:,1)),1),3);
    
    for k=1:1:size((rows(:,1)),1)
        
        %find the row in the faces array that corresponds to the shared point, thus
        %identifying the neighbouring points to the shared point 
        [r,~]=find(mesh.faces==rows(k,:)); 
                
        for j=1:1:3
            %Construct an array that contains all of the coordinates of the
            %neighbouring points 
            face(j,:)=mesh.vertices(mesh.faces(r,j),:);
            
            meanSingle=mean(face);
    
        end      
             
        meanNeigh(k,:)=meanSingle; 
        
    end 
    
    smoothedData(i,1)=mean(meanNeigh(:,1));
    smoothedData(i,2)=mean(meanNeigh(:,2));
    smoothedData(i,3)=mean(meanNeigh(:,3));
        
    clear meanNeigh;
    clear rows;
    clear rows1;
    clear rows2;
    
    % Update waitbar
    if floor(i/500)==i/500
        waitbar(i / vSize);
    end
end

mesh.vertices=smoothedData;

end

smoothedMesh.vertices=smoothedData;
smoothedMesh.faces=mesh.faces;

delete(h);