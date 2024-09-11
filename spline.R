
library(readxl)
cat("\014")
rm(list = ls())


# Loading the data and extracting the columns - yield rate and ytm

spreads = read_excel("bills and treasuries 26 jan.xlsx", 
                     sheet = "T + B")

myvars <- c("Maturity (ytm)", "Yield (sprd)")
spreads <- spreads[myvars]

spreads = t(as.matrix(spreads))

ytm = as.matrix(spreads[1,])
yield = as.matrix(spreads[2,])   # yield rows
yield = yield/100 # it's in percentage now

# Basis spline function

BSpline3 = function(k0,k1,k2,k3,k4,ytm){ # Third degree
  
  BSpline2 = function(k0,k1,k2,k3,ytm){ # Second degree
    
    BSpline1=function(k0,k1,k2,ytm){ # First degree
      
      if (ytm <= k0 | ytm >= k2) { 
        return( 0 )
      }  else if (ytm > k0 & ytm <= k1) {
        return( (ytm-k0) / ((k1-k0)*(k2-k0)) )
      }  else if (ytm > k1 & ytm < k2) {
        return( (k2-ytm) / ((k2-k0)*(k2-k1)) )
      } else { 
        return(NA) 
      }
    }
    
    return( ((ytm - k0) * BSpline1(k0, k1, k2, ytm) + (k3 - ytm) * BSpline1(k1, k2, k3, ytm)) /(k3-k0) )
  }
  
  if (is.na(ytm)) { 
    return(NA)    
  } else { 
    return( ((ytm - k0) * BSpline2(k0, k1, k2, k3, ytm) + (k4 - ytm) * BSpline2(k1, k2, k3, k4, ytm)) / (k4 - k0) ) 
  }
}

# Applying the splines function to the ytm

temp_ytm = NA
PHI = NA
nodos=NA
Ks = NA

temp_ytm = as.matrix(na.omit(ytm))

if (length(temp_ytm)>=10) nodos=25 else  nodos=length(temp_ytm) 

PHI = matrix(NA,nrow(temp_ytm),nodos)

Ks =  c(-5,-2,seq(0,25,length.out = nodos),50,60) 

for (j in 1:nrow(temp_ytm)){
  for (i in 1:(length(Ks)-4)) PHI[j,i] = BSpline3(Ks[i],Ks[i+1],Ks[i+2],Ks[i+3],Ks[i+4],temp_ytm[j])
}

# Estimating the beta for the interpolation

betas = matrix(lm(na.omit(yield) ~ 0 + PHI)$coefficients)

# Estimating the fitted values: the yields interpolated

fit_x_in = seq(0,30,by=0.25) #these are the ytm we want to estimate

fit_x_spline = matrix(NA,length(fit_x_in),(length(Ks)-4))

for (j in 1:length(fit_x_in)){
  for (i in 1:(length(Ks)-4)) fit_x_spline[j,i] = BSpline3(Ks[i],Ks[i+1],Ks[i+2],Ks[i+3],Ks[i+4],fit_x_in[j])
}

fitted_values = matrix(NA,ncol(ytm),length(fit_x_in))
fitted_values = t(fit_x_spline%*%betas)

# Plot of predicted and actual yield rates

plot(ytm, yield, ylim = c(0,0.1), xlab = "Yield to Maturity", ylab = "Yield Rate",
     pch = 20, col = "blue", main = "Yield Rate vs Yield to Maturity")
lines(fit_x_in, fitted_values, type = "l", lwd = 2, col = "red")
legend("topright", legend=c("Fitted Values", "Actual Yield Rate"), col=c("red", "blue"), lty=1:1, cex=0.8)
grid(nx = NULL, ny = NULL, col = "gray", lty = "dotted")