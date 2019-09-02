Data_dir = "/panfs/panasas01/artf/cf15322/Auto3dgm_Repeatability/1"

#Set Output directory - create own output folder
Output_dir = "/panfs/panasas01/artf/cf15322/WAuto3dgm_Repeatability/1/Output"

#Number set number of lower and higher amount of pseudolandmarks
Levels=c(400,500)

#Lower Central Incisor
#Input a vector of filenames from the meshes, corresponding to the files (without .off)
Ids = c('L_1_1_1_M','L_1_1_2_M','L_1_1_3_M','L_1_1_4_M','L_1_1_5_M','L_1_1_6_M','L_1_1_7_M','L_1_1_8_M','L_1_1_9_M','L_1_1_12_M','L_2_1_1_M','L_2_1_2_M','L_2_1_3_M','L_2_1_4_M','L_2_1_5_M','L_2_1_6_M','L_2_1_7_M','L_2_1_8_M','L_2_5_1_AS','L_2_5_2_AS','L_2_5_3_AS','L_2_5_4_AS','L_2_5_5_AS','L_2_5_6_AS','L_2_5_7_AS','L_2_5_8_AS','L_2_6_1_R','L_2_6_2_R','L_2_6_3_4','L_2_6_4_R')
#Input a vector of names for the shapes which may not be characterized by the filename. It could be a bone or specimen name but has to be the same length as Ids
Names = c('L_1_1_1_M','L_1_1_2_M','L_1_1_3_M','L_1_1_4_M','L_1_1_5_M','L_1_1_6_M','L_1_1_7_M','L_1_1_8_M','L_1_1_9_M','L_1_1_12_M','L_2_1_1_M','L_2_1_2_M','L_2_1_3_M','L_2_1_4_M','L_2_1_5_M','L_2_1_6_M','L_2_1_7_M','L_2_1_8_M','L_2_5_1_AS','L_2_5_2_AS','L_2_5_3_AS','L_2_5_4_AS','L_2_5_5_AS','L_2_5_6_AS','L_2_5_7_AS','L_2_5_8_AS','L_2_6_1_R','L_2_6_2_R','L_2_6_3_4','L_2_6_4_R')
#Align shapes
FULL = align_shapes(Data_dir, Output_dir, Levels, Ids, Names)
