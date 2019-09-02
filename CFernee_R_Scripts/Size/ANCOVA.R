# Read in Data
UI1<-read.csv("UI1.csv", header=T, row.names=1)
input <- UI1

# ANCOVA - Site and Wear 
Siteresult <- aov(Enamel.SA~DeW*Site, data = input)
print(summary(Siteresult))

# ANCOVA Plot
xyplot(Enamel.SA~DeW, data = input, col=input$Site, type=c("p","r"), xlab="Degree of Wear", ylab="Enamel SA", col.line="black") 

# ANCOVA - Sex and Wear 
Sexresult <- aov(WT.SA~DeW*Sex, data = input)
print(summary(Sexresult))


# ANCOVA - Age and Wear 
Ageresult <- aov(Enamel.SA~DeW*Age.Cagegory, data = input)
print(summary(Ageresult))


# Post Hoc Test for Site
tukey.test <-TukeyHSD(Siteresult, 'Site')
plot(tukey.test)


