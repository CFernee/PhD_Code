% Only changes fv2!
function [fv2_TA]=manRot(Target,Xrot,Yrot,Zrot)

Xrot=convang(Xrot,'deg','rad');
Yrot=convang(Yrot,'deg','rad');
Zrot=convang(Zrot,'deg','rad');

%Rotate the vertices of the Target mesh into a new mesh fv2_TA
%X alignment
fv2_TA.vertices=rodrigues_rot(Target.vertices,[1 0 0],Xrot);

%Y alignment
fv2_TA.vertices=rodrigues_rot(fv2_TA.vertices,[0 1 0],Yrot);

%Z alignment
fv2_TA.vertices=rodrigues_rot(fv2_TA.vertices,[0 0 1],Zrot);

fv2_TA.faces=Target.faces;
end
