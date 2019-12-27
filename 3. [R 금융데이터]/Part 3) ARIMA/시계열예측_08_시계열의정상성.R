
###############
# Stationaity #
###############

library(forecast)
library(tseries)

########################
# simulate white noise #
########################

set.seed(1234) 
white_noise <- rnorm(1000)
ts.plot(white_noise)

 
########################
# simulate random walk #
########################

set.seed(123)  

x <- rnorm(1)
w <- rnorm(1000)
for(t in 2:1000){ x[t] <- x[t-1] + w[t] }
ts.plot(x)


#############################
# Detrending : Differencing #
#############################

par(mfrow=c(2,1))
plot(AirPassengers)
plot(diff(AirPassengers))


##############################
# Stabilizing Variance : Log #
##############################

par(mfrow=c(3,1))
plot(AirPassengers)
plot(diff(AirPassengers))
plot(diff(log(AirPassengers)))

###################################
# acf : Auto Correlation Function #
###################################

par(mfrow=c(2,1))
acf(AirPassengers)
acf(diff(log(AirPassengers)))





