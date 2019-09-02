function [G] = vectorPlane(P1,P2,P3,point)

%Define vectors P1P2 and P1P3 using known vertex points P1, P2 and P3
P1P2 = P2 - P1;
P1P3 = P3 - P1;

%Find normal plane by solving the cross product of the two vectors. Giving
%answers for vector coefficients A, B and C
normal = cross(P1P2,P1P3,2);     
     
%Rearrange normal vector equation for (d) - constant;
%Substitute values from P1 using coefficients A, B and C to solve for d. using
%equation A*(x1)+B*(y1)+C*(z1)+d=0
%the plane will equal coefficients of the normal vector plan and (d)
d = dot(normal,P1,2);

%%
%Find the closest distance between the point and the plane using the normal
%plane equation; distance=(Au+Bv+Cw+d)/sqrt(A^2+B^2+C^2)
%distance = abs((dot(normal,point) - d)/norm(normal));

%% Find the projection of the point onto the plane
%find constant (t) for the point on the line where the line intersects the
%plane i.e. t=-(au+bv+cw+d)/(a^2+b^2+c^2)
t = - (normal(:,1).*point(:,1) + normal(:,2).*point(:,2) + normal(:,3).*point(:,3) - d)...
./(sum(normal.^2,2));

%Use calculated value of (t) to find coordinates of vector at the point of
%intersection i.e. x=u+at, y=v+bt, z=w+ct
G = [point(:,1) + normal(:,1).*t(:,1), point(:,2) + normal(:,2).*t(:,1), point(:,3) + normal(:,3).*t(:,1)];
    
