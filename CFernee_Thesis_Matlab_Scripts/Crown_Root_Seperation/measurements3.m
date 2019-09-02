function [LOCla,LOCli,LORla,LORli,MDC,MDCc,LDC,LDCc,COCJmLi,COCJmLa,COCJdLi,COCJdLa]=measurements3(Dentin,Enamel,FigureNo)

%Inputs
% Dentin = .stl mesh of dentin shell 
% Enamel = .stl mesh of enamel shell 
%both meshes must be alligned in 3D space to correspond to the complete
%tooth form.

%%%New Measurements.
%(LOCla) = Length of Crown (labial) 
%(LOCli) = Length of Corwn (lingual) 
%(LORla) = Length of Root (labial)
%(LORli) = Length of Root (lingual)
%(MDC) = Mesiodistal Diameter of Crown
%(MDCc) = Mesiodistal Diameter of Crown at Cervix
%(LDC) = Labiolingual Diameter of Crown
%(LDCc) = Labiolingual Diameter of Crown at Cervix
%(COCJmLi) = Curvature of Cementoenamel Junction on Mesial/Lingual
%(COCJmLa) = Curvature of Cementoenamel Junction on Mesial/Labial
%(COCJdLi) = Curvature of Cementoenamel Junction on Distal/Lingual
%(COCJdLa) = Curvature of Cementoenamel Junction on Distal/Labial

%%
%Import enamel mesh and dentin mesh 
%Dentin=stlread('G:\ImplantProject\ToothTransfer260814\AllTeeth\L.1\L.1.1.01\RootShell.stl');
%Enamel=stlread('G:\ImplantProject\ToothTransfer260814\AllTeeth\L.1\L.1.1.01\EnamelShell.stl');

%%
%Find Data Max/Min references.
%Dentin
[dentMin]=min(Dentin.vertices);
[dentMinX]=dentMin(1);
[dentMinY]=dentMin(2);
[dentMinZ]=dentMin(3);

[dentMax]=max(Dentin.vertices);
[dentMaxX]=dentMax(1);
[dentMaxY]=dentMax(2);
[dentMaxZ]=dentMax(3);

%Enamel
[enamMin]=min(Enamel.vertices);
[enamMinX]=enamMin(1);
[enamMinY]=enamMin(2);
[enamMinZ]=enamMin(3);

[enamMax]=max(Enamel.vertices);
[enamMaxX]=enamMax(1);
[enamMaxY]=enamMax(2);
[enamMaxZ]=enamMax(3);

%%
%Split meshes by anotomic planes. 
%Distal Dentin
[dentDist]=Dentin;
[dentCentY]=(dentMaxY+dentMinY)/2;
[dentDistVerts]=find(Dentin.vertices(:,2)<dentCentY);

for i=1:size(dentDistVerts,1)
    
    dentDist.vertices(dentDistVerts(i),:)=NaN;

end
[maxDentDistZ]=max(dentDist.vertices(:,3));

%Mesial Dentin
[dentMes]=Dentin;
[dentMesVerts]=find(Dentin.vertices(:,2)>dentCentY);

for i=1:size(dentMesVerts,1)
    
    dentMes.vertices(dentMesVerts(i),:)=NaN;

end
[maxMesDistZ]=max(dentMes.vertices(:,3));

%Anterior Enamel
[enamAnt]=Enamel;
[enamCentX]=(enamMaxX+enamMinX)/2;
[enamAntVerts]=find(Enamel.vertices(:,1)>enamCentX);

for i=1:size(enamAntVerts,1)
    
    enamAnt.vertices(enamAntVerts(i),:)=NaN;

end
[minAntEnamZ]=min(enamAnt.vertices(:,3));

%Posterior Enamel
[enamPos]=Enamel;
[enamPosVerts]=find(Enamel.vertices(:,1)<enamCentX);

for i=1:size(enamPosVerts,1)
    
    enamPos.vertices(enamPosVerts(i),:)=NaN;
    
end
[minPosEnamZ]=min(enamPos.vertices(:,3));

%%
%Take core measurements 

%Length of Crown (labial) - (LOCla)
[LOCla]=enamMaxZ-minAntEnamZ;

%Length of Crown (lingual) - (LOCli)
[LOCli]=enamMaxZ-minPosEnamZ;

%Length of Root (labial) - (LORla)
[LORla]=minAntEnamZ-dentMinZ;

%Length of Root (lingual) - (LORli)
[LORli]=minPosEnamZ-dentMinZ;

%Mesiodistal Diameter of Crown - (MDC)
[MDC]=enamMaxY-enamMinY;

%Mesiodistal Diameter of Crown at Cervix - (MDCc)
[DentDistMaxNodeCoorVert,~,~]=find(dentDist.vertices(:,3)==maxDentDistZ);
[MDCYmax]=dentDist.vertices(DentDistMaxNodeCoorVert(1),2);

[DentMesMaxNodeCoorVert,~,~]=find(dentMes.vertices(:,3)==maxMesDistZ);
[MDCYmin]=dentMes.vertices(DentMesMaxNodeCoorVert(1),2);

[MDCc]=MDCYmax-MDCYmin;

%Labiolingual Diameter of Crown - (LDC)
[LDC]=enamMaxX-enamMinX;

%Labiolingual Diameter of Crown at Cervix - (LDCc)
[enamAntMaxNodeCoorVert,~,~]=find(enamAnt.vertices(:,3)==minAntEnamZ);
[LDCcXmin]=enamAnt.vertices(enamAntMaxNodeCoorVert(1),1);

[enamPosMaxNodeCoorVert,~,~]=find(enamPos.vertices(:,3)==minPosEnamZ);
[LDCcXmax]=enamPos.vertices(enamPosMaxNodeCoorVert(1),1);

[LDCc]=LDCcXmax-LDCcXmin;

%Curvature of Cementoenamel Junction on Mesial/Lingual - (COCJmLi)
[COCJmLi]=maxMesDistZ-minAntEnamZ;

%Curvature of Cementoenamel Junction on Mesial/Labial - (COCJmLa)
[COCJmLa]=maxMesDistZ-minPosEnamZ;

%Curvature of Cementoenamel Junction on Distal/Lingual - (COCJdLi)
[COCJdLi]=maxDentDistZ-minAntEnamZ;

%Curvature of Cementoenamel Junction on Distal/Labial - (COCJdLa)
[COCJdLa]=maxDentDistZ-minPosEnamZ;


%%Plot Landmarks
overplot(Enamel,Dentin,FigureNo);
hold all

%enamMaxZ
[r,~,~]=find(Enamel.vertices(:,3)==enamMaxZ);
enamMaxZpoint=Enamel.vertices(r(1),:);
scatter3(enamMaxZpoint(1),enamMaxZpoint(2),enamMaxZpoint(3),'r','fill');

%minAntEnamZ (LDCcXmin)
[r,~,~]=find(enamAnt.vertices(:,3)==minAntEnamZ);
minAntEnamZpoint=enamAnt.vertices(r(1),:);
scatter3(minAntEnamZpoint(1),minAntEnamZpoint(2),minAntEnamZpoint(3),'r','fill');

%minPosEnamZ (LDCcXmax)
[r,~,~]=find(enamPos.vertices(:,3)==minPosEnamZ);
minPosEnamZpoint=enamPos.vertices(r(1),:);
scatter3(minPosEnamZpoint(1),minPosEnamZpoint(2),minPosEnamZpoint(3),'r','fill');

%dentMinZ
[r,~,~]=find(Dentin.vertices(:,3)==dentMinZ);
dentMinZpoint=Dentin.vertices(r(1),:);
scatter3(dentMinZpoint(1),dentMinZpoint(2),dentMinZpoint(3),'r','fill');

%enamMaxY
[r,~,~]=find(Enamel.vertices(:,2)==enamMaxY);
enamMaxYpoint=Enamel.vertices(r(1),:);
scatter3(enamMaxYpoint(1),enamMaxYpoint(2),enamMaxYpoint(3),'r','fill');

%enamMinY
[r,~,~]=find(Enamel.vertices(:,2)==enamMinY);
enamMinYpoint=Enamel.vertices(r(1),:);
scatter3(enamMinYpoint(1),enamMinYpoint(2),enamMinYpoint(3),'r','fill');

%MDCYmax
MDCYmaxpoint=dentDist.vertices(DentDistMaxNodeCoorVert(1),:);
scatter3(MDCYmaxpoint(1),MDCYmaxpoint(2),MDCYmaxpoint(3),'r','fill');

%MDCYmin
MDCYminpoint=dentMes.vertices(DentMesMaxNodeCoorVert(1),:);
scatter3(MDCYminpoint(1),MDCYminpoint(2),MDCYminpoint(3),'r','fill');

% %enamMaxX
[r,~,~]=find(Enamel.vertices(:,1)==enamMaxX);
enamMaxXpoint=Enamel.vertices(r(1),:);
scatter3(enamMaxXpoint(1),enamMaxXpoint(2),enamMaxXpoint(3),'r','fill');

%enamMinX
[r,~,~]=find(Enamel.vertices(:,1)==enamMinX);
enamMinXpoint=Enamel.vertices(r(1),:);
scatter3(enamMinXpoint(1),enamMinXpoint(2),enamMinXpoint(3),'r','fill');

%maxMesDistZ
[r,~,~]=find(dentMes.vertices(:,3)==maxMesDistZ);
maxMesDistZpoint=dentMes.vertices(r(1),:);
scatter3(maxMesDistZpoint(1),maxMesDistZpoint(2),maxMesDistZpoint(3),'r','fill');

%maxDentDistZ
[r,~,~]=find(dentDist.vertices(:,3)==maxDentDistZ);
maxDentDistZpoint=dentDist.vertices(r(1),:);
scatter3(maxDentDistZpoint(1),maxDentDistZpoint(2),maxDentDistZpoint(3),'r','fill');
end

