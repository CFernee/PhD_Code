#Load Data 
All<-read.csv("All_SA_and_Vol.csv", header=T, row.names=1)


#Create data frame 
AllData.data <- data.frame(All$Sex, All$DeW)

#Create a table with needed variables 
AllTeeth.data =  table(All$Sex, All$DeW)
print(AllTeeth.data)
write.csv(AllTeeth.data,'All_Sex_Wear')

#Perform Chi-square 
print(chisq.test(AllTeeth.data))
