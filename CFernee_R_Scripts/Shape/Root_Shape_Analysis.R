setwd("")
#Open geomorph
library("geomorph")

#Read in 'pseudolandmark' morphologika files 
rootfiles<-read.morphologika("morphologika_2.txt")


#Create Excel file of classifiers, called classifer.csv. Read in file 
classifier<-read.csv("classifier.csv", header=T, row.names=1)
#Check whether worked 
is.factor(classifier$Period)

#Next GPA
#Before this need to curve sliders and surface sliders if use them need to be read in 
sliders<-as.matrix(read.csv("surfslide.csv", header=T))
#GPA if no sliders 
#Y.gpagen<-gpagen(rootfiles)
#Perform GPA using procrustes distances for sliding, after this the procrustes coordinates are used (Y$coords)
Y.gpagen<-gpagen(rootfiles, curves = NULL, sliders) 


#3D mean shape 
#Workout mean shape - based on landmark coordinates
ref<-mshape(Y.gpagen$coords)
#Identify speciemen that is closest to mean shape 
findMeanSpec(Y.gpagen$coords)
#Read in .ply file of mean shape 
Mshape<-read.ply('GC_22_Max_9_.ply')
#Assign a colour to PLY file if need be using color or RGB code 
Mshape$material<-"blue"
#Warp mesh
averagemesh<-warpRefMesh(Mshape,rootfiles[,,13],ref,color = NULL, centered = FALSE)
writePLY('averagemesh.ply')
rgl.close()
#Plot reference differences using a surface and 3D data , it uses the average mesh produced using warpRefMesh(above)
#Function can be used to show deformations between any 2 sets of coordinates e.g. extreme PCs
plotRefToTarget(M1=ref, M2=Y.gpagen$coords[,,1], mesh = averagemesh, method = "surface")

#PCA 
PCA<-plotTangentSpace(Y.gpagen$coords, groups=classifier$Period)
#Can change which axes are plotted
plotTangentSpace(Y.gpagen$coords, axis1 = 2, axis2 = 3,groups=classifier$Period)
#Get PC Scores 
PCScores<-PCA$pc.scores
#Export as csv
write.csv(PCScores,'PCScores.csv')
#Plot Min and Max PC shapes using average mesh
plotRefToTarget(M1=ref, M2=res$pc.shapes$PC1max, mesh = averagemesh, method = "surface")
plotRefToTarget(M1=ref, M2=res$pc.shapes$PC1min, mesh = averagemesh, method = "surface")
plotRefToTarget(M1=ref, M2=res$pc.shapes$PC2max, mesh = averagemesh, method = "surface")
plotRefToTarget(M1=ref, M2=res$pc.shapes$PC2min, mesh = averagemesh, method = "surface")


#Create Geomorph Data frame which holds all data
#Add variables from classifier file 
gdf<-geomorph.data.frame(shape = Y.gpagen$coords, period = classifier$Period, sex = classifier$Sex, age = classifier$Age, side=classifier$Tooth)
#Can check whats in it 
gdf 
#Procrustes ANOVA - shape variation and covariation for Period
procD.lm(shape~period, data = gdf, iter = 999)
#Can allow resampling - "random"= full resampling for Period
procD.lm(shape~period, data = gdf, iter = 999, seed="random")


#Allometric Regression
# Root length 
RootSA_Allometry<-procD.allometry(rootfiles~rootlength, ~period, logsz = TRUE, data=gdf, iter=999)
plot(RootSA_Allometry, method = "RegScore")

# Root SA
RootLength_Allometry<-procD.allometry(rootfiles~rootSA, ~period, logsz = TRUE, data=gdf, iter=999)
plot(RootLength_Allometry, method = "RegScore")