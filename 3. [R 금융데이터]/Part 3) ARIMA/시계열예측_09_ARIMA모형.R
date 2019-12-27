
#########
# ARIMA #
#########

library(forecast)
library(tseries)


###############################
## simulate AR(1), phi = 0.9
###############################

set.seed(123456)
ar1 <- arima.sim(n=1000, list(ar=c(0.9))) 
ts.plot(ar1)


###########################
# Random Walk & Explosive #
###########################

eps <- rnorm(1000) 
eps2 <- rnorm(1000) 
y <- eps 
x <- eps2 
for (t in 2:1000) { 
  y[t] <- y[t-1] + eps[t] 
  x[t] <- 1.05*x[t-1] + eps2[t] }

par(mfrow=c(2,2)) 
plot(y[1:40], type = "l", main = "a = 1") 
plot(x[1:40], type = "l", main = "a = 1.05") 
plot(y, type = "l", main = "a = 1") 
plot(x, type = "l", main = "a = 1.05")

#################################################
# Unit Root test : Augmented Dichey Fuller Test #
#################################################

adf.test(AirPassengers)
