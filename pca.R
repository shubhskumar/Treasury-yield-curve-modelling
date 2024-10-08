rm(list=ls())
cat("\014")

library(rgl)

datapath<-"C:/Users/josel/OneDrive - The University of Chicago/Clases/2nd Q/Linear and non linear/final project/PCA"

AssignmentData<-
  read.csv(file=paste(datapath,"RegressionAssignmentData2023.csv",sep="/"),
           row.names=1,header=TRUE,sep=",")[,1:7]
dim(AssignmentData)


head(AssignmentData)


#matplot(AssignmentData[,-c(8,9,10)],type='l',ylab="Interest Rates",
#        main="History of Interest Rates",xlab="Index")



################################

library(xts)

rownames(AssignmentData) <- as.Date(rownames(AssignmentData), format = "%m/%d/%Y")

AssignmentData = as.xts(AssignmentData)

plot(AssignmentData,type='l',ylab="Interest Rates",
     main="History of Interest Rates",xlab="Index")

#################################


## eigen decomposition 

PCA <- princomp(AssignmentData)

summary(PCA)

# Calculate the proportion of variance explained by each principal component
variance_explained <- PCA$sdev^2 / sum(PCA$sdev^2)

# Calculate cumulative variance explained
cumulative_variance <- cumsum(variance_explained)

cumulative_variance

barplot(cumulative_variance,
        width=2,col = "black",names.arg=c("F1","F2","F3","F4","F5","F6","F7"),
        main="Importance of Factors")



# factor loadings (just the first 3)

Loadings <- PCA$loadings[,1:3]

Maturities<-c(.25,.5,2,3,5,10,30)
matplot(Maturities,Loadings,type="l",lty=1,col=c("black","blue","orange"),
        lwd=3,main="factor Loadings")
abline(h=0)
legend("bottomright",legend=c("L1","L2","L3"),
       col=c("black","blue","orange"),lty=1,cex=.5)


# factors 

Factors = PCA$scores

Factors = as.xts(Factors)

plot(Factors[,c(1:3)],type="l",col=c("black","blue","orange"),lty=1,lwd=3, main = "Factors 1-3" )
legend("topright",legend=c("F1","F2","F3"),
       col=c("black","blue","orange"),lty=1,cex=.5)



# Save duration factor

Duration<-PCA$scores[,1]

write.csv(Duration,file=paste(datapath,"DurationFactor.csv",sep = "/"))



