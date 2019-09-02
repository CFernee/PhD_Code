function [inside, NearestVertex, rho, D] =  insideTriangle(P1, P2, P3, G, point)
%% Check if G lies within the target face
% solved using Barycentric Coordinates theory
% as described in http://www.blackpawn.com/texts/pointinpoly/default.html

% Compute vectors
v0 = P3 - P1;
v1 = P2 - P1;
v2 = G - P1;

% Compute dot products
dot00 = dot(v0, v0,2);
dot01 = dot(v0, v1,2);
dot02 = dot(v0, v2,2);
dot11 = dot(v1, v1,2);
dot12 = dot(v1, v2,2);

% Compute barycentric coordinates
invDenom = 1./(dot00.*dot11 - dot01.*dot01);
u = (dot11.*dot02 - dot01.*dot12).*invDenom;
v = (dot00.*dot12 - dot01.*dot02).*invDenom;

%Initialize D with a matrix of zeros
loopSize = size(P1,1);
D = zeros([loopSize,3]);

for i=1:loopSize
    % Check if point is in triangle
    if (u(i) >= 0) && (v(i) >= 0) && (u(i) + v(i) < 1)
        % Value lies inside triangle
        inside = 1;
        NearestVertex = [0];
        rho(i)=norm((G(i,:)-point),2);
        D(i,:)=G(i,:)-point;
    else
        % If it is determined that the point lies outside of the triangle the
        % nearest vertex is determined using the magnitude of each vector to
        % intersection point. The lowest vector is returned and used to
        % reference the equivalent vertex
        inside = 0;

        P1G = G(i,:) - P1(i,:);
        P2G = G(i,:) - P2(i,:);
        P3G = G(i,:) - P3(i,:);
        FaceVertices = [P1(i,:); P2(i,:); P3(i,:)];

        P = [norm(P1G,2), norm(P2G,2), norm(P3G,2)];
        [minNum, minIndex] = min(P(:));
        [col] = ind2sub(size(P), minIndex);
        NearestVertex=FaceVertices(col,:);
        % Find magnitiude of positional differecnce b/w baseline vertex and
        % target vertex
        rho(i)=(norm((G(i,:)-point),2))+(norm((NearestVertex-G(i,:)),2));
        % Find deformation field vector b/w baseline and target vertex
        D(i,:)=NearestVertex-point;
    end
end
