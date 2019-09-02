function [W]=morphedMesh(D,baselineVertices,baselineFaces)
% D=D1x;
% baselineVertices=fv1_T.vertices;
% baselineFaces=fv1_T.faces;

W.vertices=D+baselineVertices;
W.faces=baselineFaces;

%final_plot(W,2);