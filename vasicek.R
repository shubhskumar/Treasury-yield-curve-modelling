rm(list=ls())
cat("\014")

library(xts)


datapath<-"C:/Users/josel/OneDrive - The University of Chicago/Clases/2nd Q/Linear and non linear/final project/PCA"
Duration<-
  read.csv(file=paste(datapath,"DurationFactor.csv",sep="/"),
           row.names=1,header=TRUE,sep=",")

datapath<-"C:/Users/josel/OneDrive - The University of Chicago/Clases/2nd Q/Linear and non linear/final project/vasicek"
JPM <-  read.csv(file=paste(datapath,"JPM.csv",sep="/"),
                 row.names=1,header=TRUE,sep=",")



# Assuming your dataframes are already loaded as Duration and JPM

# Convert rownames to Date objects for Duration dataframe
rownames(Duration) <- as.Date(rownames(Duration))

# Convert rownames to Date objects for JPM dataframe
rownames(JPM) <- as.Date(rownames(JPM))

# Find common dates
common_dates <- intersect(rownames(Duration), rownames(JPM))

# Subset dataframes to keep only common dates
Duration <- Duration[common_dates, , drop = FALSE]
JPM <- JPM[common_dates, , drop = FALSE]


#calculate the returns - the data is not stationary 
ret_jpm = diff(JPM$Close)/JPM$Close[-nrow(JPM)]
diff_dur = diff(Duration$x)

ret_jpm = as.xts(data.frame(ret_jpm,row.names = rownames(JPM)[-1]))
diff_dur = as.xts(data.frame(diff_dur,row.names = rownames(JPM)[-1]))

plot(ret_jpm,type = "l")
plot(diff_dur,type = "l")

#correlation between factor and the company asset value

rho = as.numeric(cor(diff_dur,ret_jpm))


#unconditional probability of default 

p_astk = 0.01

#conditional probability of default

prob_cond = pnorm((qnorm(p_astk)-diff_dur*sqrt(rho))/sqrt(1-rho))


plot(prob_cond[-c(1:4600)],type = "l", main = "Probability of default JPMorgan conditional on Duration Factor", ylim = c(0,0.025))


### Goldman Sachs -----------



datapath<-"C:/Users/josel/OneDrive - The University of Chicago/Clases/2nd Q/Linear and non linear/final project/PCA"
Duration<- read.csv(file=paste(datapath,"DurationFactor.csv",sep="/"),
                    row.names=1,header=TRUE,sep=",")

datapath<-"C:/Users/josel/OneDrive - The University of Chicago/Clases/2nd Q/Linear and non linear/final project/vasicek"
GS <-  read.csv(file=paste(datapath,"GS.csv",sep="/"),
                row.names=1,header=TRUE,sep=",")




# Assuming your dataframes are already loaded as Duration and GS

# Convert rownames to Date objects for Duration dataframe
rownames(Duration) <- as.Date(rownames(Duration))

# Convert rownames to Date objects for GS dataframe
rownames(GS) <- as.Date(rownames(GS))

# Find common dates
common_dates <- intersect(rownames(Duration), rownames(GS))

# Subset dataframes to keep only common dates
Duration <- Duration[common_dates, , drop = FALSE]
GS <- GS[common_dates, , drop = FALSE]


#calculate the returns - the data is not stationary 
ret_GS = diff(GS$Close)/GS$Close[-nrow(GS)]
diff_dur = diff(Duration$x)

ret_GS = as.xts(data.frame(ret_GS,row.names = rownames(GS)[-1]))
diff_dur = as.xts(data.frame(diff_dur,row.names = rownames(GS)[-1]))

plot(ret_GS,type = "l")
plot(diff_dur,type = "l")

#correlation between factor and the company asset value

rho = as.numeric(cor(diff_dur,ret_GS))


#unconditional probability of default 

p_astk = 0.01

#conditional probability of default

prob_cond = pnorm((qnorm(p_astk)-diff_dur*sqrt(rho))/sqrt(1-rho))


plot(prob_cond,type = "l", main = "Probability of default of GS conditional on Duration Factor", ylim=c(0,0.025))

pnorm((qnorm(p_astk)-1.16707*sqrt(rho))/sqrt(1-rho))
pnorm((qnorm(p_astk)+1.171809*sqrt(rho))/sqrt(1-rho))


# diff_dur[which.max(diff_dur)]
# diff_dur[which.min(diff_dur)]
# 
# prob_cond[which.max(prob_cond)]
# prob_cond[which.min(prob_cond)]

