function [Dmin,RhoMin]=displacementMag3(centroid,vertices_1,vertices_2,faces_2,Num_Near_Neig)
%  centroid=centroid_2;
%  vertices_1=fv1_T.vertices;
%  vertices_2=fv2_T.vertices;
%  faces_2=fv2_T.faces;    
%  Num_Near_Neig=30;

% Set a wait bar
h=waitbar(0, 'Calculating...', 'CreateCancelBtn', 'setappdata(gcbf, ''cancelling'',1)');
set(h,'windowstyle','modal');

%mex kdtree_build.cpp
%tree=kdtree_build(centroid);

%mex kdtree_k_nearest_neighbors.cpp

vSize = size(vertices_1,1);
for i=1:1:vSize;
    % Check for if user has pressed the cancel button on the wait window
    if getappdata(h, 'cancelling');
       	break
    end
    
    [idx]=knn(vertices_1(i,:),centroid,Num_Near_Neig);
    %[idx2,dist]=knnsearch(centroid,vertices_1(i,:),'K',Num_Near_Neig);
    [idx_T]=idx';
    %idxs = kdtree_k_nearest_neighbors(tree,vertices_1(i,:),Num_Near_Neig);
    
    point = vertices_1(i,:);
   
    P1 = vertices_2(faces_2(idx_T(:,1),1),:);
    P2 = vertices_2(faces_2(idx_T(:,1),2),:);
    P3 = vertices_2(faces_2(idx_T(:,1),3),:);
    
    % finds the vector of the point of intersection between meshes
    G = vectorPlane(P1, P2, P3, point);
    
    %Check if G is inside the triangles formed by P1, P2 and P3
    [inside, NearestVertex, rho, D] = insideTriangle(P1, P2, P3, G, point);
    
    %Find minimum value of rho and use to find smallest (D)
    [minNum, minIndex] = min(rho(:));
    [RhoMin(i,:)] = min(rho(:));
    [col] = ind2sub(size(rho), minIndex);
    [Dmin(i,:)] = D(col,:);
    %Dcol(i,:)=col;
   
    % Update waitbar
    if floor(i/500)==i/500
        waitbar(i / vSize);
    end
end

delete(h);