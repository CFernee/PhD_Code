%%Mesh Registration

%Clear previous workspace data
clear

%Turn on profiler, to time all the functions
profile on

%Baseline Tooth import (Purple)
%[f1,v1]=stlread('C:\Users\cjw1e12\Documents\Implant Project\SSM\Tooth\PreProcessing\Hart_Can_Man_3.2.stl');
[fv1]=stlread('G:\ImplantProject\SSM(E)\5.Individual_aligned_teeth_stl_files\L.1\mean_L1_ref.stl');
%Target Mesh import (Blue)
%[f2,v2]=stlread('C:\Users\cjw1e12\Documents\Implant Project\SSM\Tooth\PreProcessing\Hart_Can_Man_4.2.stl');
[fv2]=stlread('G:\ImplantProject\SSM(E)\5.Individual_aligned_teeth_stl_files\L.1\Aligned\WT-Test\L.1.1.5_align_WT.stl');

%Translate both files to orientate the centre of volume about the origin.
%Plots translated meshes
[fv1_T,fv2_T]=translate(fv1,fv2);

%%
% *BOLD TEXT*
% Manual translation of Target (Blue)
[fv2_TA]=manTranslate(fv2_T,0,0,0);

%Manual Target (blue) alignment %create funtion whereby the user inputs the
%rotation in the X,Y and Z axis and a plot of the results is created
%input in degrees (not rad)
[fv2_TA]=manRot(fv2_TA,0,0,0);

%Rotate target mesh to align with the baseline using Iterative Closest
%Point
%Plots rotated meshes
[fv2_TR]=STLRotate(fv1_T,fv2_TA);

%Find the centroid of each facet for both models 
[centroid_1,centroid_2]=faceCentroid(fv1,fv2);


%%
%Find displacement field vercors (D) and distances (rho) from baseline to
%target. Sampling nearest 30 target centroids to baseline vertex 
%[D1x]=displacement(centroid_2,fv1_T.vertices,fv2_TA.vertices,fv2_TA.faces,30);
profile on
[D1x,Rho]=displacementMag3(centroid_2,fv1.vertices,fv2.vertices,fv2.faces,30);
[W_213]=displacementMag4(centroid_2,fv1,fv2,30,3);
profile viewer
%Find displacement field vercors (D) and distances (rho) from target to
%baseline
%[D2x]=displacement(centroid_1,fv2_TR.vertices,fv1_T.vertices,fv1_T.faces,30);

%Create and plot morphed mesh of baseline to target
%This was originally W_4 (mistake or not?), so I changed it to W_2.
[W_2]=morphedMesh(D1x,fv1.vertices,fv1.faces);

%Create column vector for morphed baseline mesh 
[x2]=columnVector(W_2.vertices);

%%
%Find Gaussian weights

% [G1,G2]=gaussian(fv1_T.verticies,fv2_T.verticies,D2x); %sort input data
% 
% [DS]=smoothedDisplacement(G1,D1x,G2,D2x,gamma) %sort input data - combine into for loop.

%%

% View profiler results
profile viewer
%p = profile('info');
%profsave(p,'profile_results');
profile off
