
##################
# ARIMA Modeling #
##################

library(forecast)
library(tseries)



#############
# ACF, PACF #
#############

plot(AirPassengers)


par(mfrow=c(2,1))
acf(AirPassengers) 
pacf(AirPassengers)



###############
# white-noise #
###############

set.seed(1234) 
white_noise <- rnorm(1000)
ts.plot(white_noise)

par(mfrow=c(2,1))
acf(white_noise) 
pacf(white_noise)

###############
# Random walk #
###############

set.seed(123)  

x <- rnorm(1)
w <- rnorm(1000)
for(t in 2:1000){ x[t] <- x[t-1] + w[t] }
ts.plot(x)

par(mfrow=c(2,1))
acf(x, main = "Random Walk") 
pacf(x, main = "Random Walk")


par(mfrow=c(2,1))
acf(diff(x), main = "Differenced Random Walk") 
pacf(diff(x), main = "Differenced Random Walk")


####################
# AR(1), phi = 0.9 #
####################

set.seed(123456)
ar1 <- arima.sim(n=1000, list(ar=c(0.9))) 
ts.plot(ar1)

par(mfrow=c(2,1))
acf(ar1)
pacf(ar1)

######################
# MA(1), theta = 0.9 #
######################

set.seed(123456)
ma1 <- arima.sim(n = 1000, list(ma=c(0.8)))
ts.plot(ma1)

par(mfrow=c(2,1))
acf(ma1)
pacf(ma1)



##############
# auto.arima #
##############

# evaluate models by AICc, AIC, BIC
# choose lowest AICc

auto.arima(AirPassengers)
auto.arima(AirPassengers, trace=T) 
auto.arima(diff(AirPassengers)) 

auto.arima(AirPassengers)

arima(AirPassengers, c(2, 1, 1), seasonal = list(order = c(0, 1, 0), period = 12))


####################
## ARIMA Forecasting
####################

fit <- auto.arima(AirPassengers)
fcst <- forecast(fit, h = 10*12)
plot(fcst)

attributes(fcst) 
fcst$mean 

ts.plot(AirPassengers, fcst$mean, lty = c(1,3))
