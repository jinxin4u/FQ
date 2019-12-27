library(forecast)


###########################
# Time Series Forecasting #
###########################

#####################
# AirPassenger Data #
#####################

data(AirPassengers)
AP <- AirPassengers

# Modeling set & Test set  

AP_ms <- AP[1:132] # modeling set
AP_ts <- AP[133:144] # test set

y <- ts(AP_ms, frequency=12) # modeling set 

# Exponential Moving Average 1

fit <- HoltWinters(y, beta=FALSE, gamma=FALSE) # Exp.MA learning
fc <- forecast(fit, h=12)  
plot(fc, main = "Exponential Moving Average Forecasts") 

# Exponential Moving Average 2

fit <- HoltWinters(y, alpha = 0.1, beta=FALSE, gamma=FALSE) # Exp.MA learning
fc <- forecast(fit, h=12)  
plot(fc, main = "Exponential Moving Average Forecasts") 

# 1-MAPE

mean(100-100*abs(as.numeric(fc$mean)-as.numeric(AP_ts))/as.numeric(AP_ts))


# HoltWinters

fit1 <- HoltWinters(y)
fc1<- forecast(fit1, h=12)
plot(fc1, main = "HoltWinters Forecasts")

mean(100-100*abs(as.numeric(fc1$mean)-as.numeric(AP_ts))/as.numeric(AP_ts))

# hw

fit2 <- hw(y)
fc2 <- forecast(fit2, h=12)
plot(fc2, main = "hw Forecasts")

mean(100-100*abs(as.numeric(fc2$mean)-as.numeric(AP_ts))/as.numeric(AP_ts))


# stl

fit3 <- stl(y, s.window = "per")
fc3 <- forecast(fit3, h=12)
plot(fc3, main = "stl Forecasts")

mean(100-100*abs(as.numeric(fc3$mean)-as.numeric(AP_ts))/as.numeric(AP_ts))


########################
# US unemployment Data #
########################

USunemp <- read.csv("C:/Users/kykim/Documents/Fast_Campus_Online/TS_Online/Ch_1/USunemp.csv")

# Modeling set & Test set  

us_ms <- USunemp$USun[1:118] # modeling set
us_ts <- USunemp$USun[119:130] # test set 

y <- ts(us_ms, frequency=12) # modeling set 


# par(mfrow=c(3,1))

# Exponential Moving Average 

fit <- HoltWinters(y, beta=FALSE, gamma=FALSE) # Exp.MA learning
fc <- forecast(fit, h=12)  
plot(fc, main = "Exponential Moving Average Forecasts") 

mean(100-100*abs(as.numeric(fc$mean)-as.numeric(us_ts))/as.numeric(us_ts))

# Holt-Winters 

fit <- hw(y)
fc <- forecast(fit, h=12)
plot(fc, main = "Holt-Winters Forecasts")

mean(100-100*abs(as.numeric(fc$mean)-as.numeric(us_ts))/as.numeric(us_ts))

# stl 

fit <- stl(y, s.window = "periodic")
fc <- forecast(fit, h=12)
plot(fc, main = "STL Forecasts")

mean(100-100*abs(as.numeric(fc$mean)-as.numeric(us_ts))/as.numeric(us_ts))


#################################
# Quaterly Exchange rate in $NZ #
#################################

Z <- read.csv("C:/Users/kykim/Documents/Fast_Campus_Online/TS_Online/Ch_1/pounds_nz.csv")

#  Modeling set & Test set  

z_ms <- Z$xrate[1:35] # modeling set
z_ts <- Z$xrate[36:39] # test set 

y <- ts(z_ms, frequency=4) # modeling set, quarterly data : frequency = 4 

# par(mfrow=c(3,1))

# Exponential Moving Average

fit <- HoltWinters(y, beta=FALSE, gamma=FALSE) 
fc <- forecast(fit, h=4)  
plot(fc, main = "Exponential Moving Average Forecasts") 

mean(100-100*abs(as.numeric(fc$mean)-as.numeric(z_ts))/as.numeric(z_ts))

# Holt-Winters 

fit <- hw(y)
fc <- forecast(fit, h=4)
plot(fc, main = "Holt-Winters Forecasts")

mean(100-100*abs(as.numeric(fc$mean)-as.numeric(z_ts))/as.numeric(z_ts))


# stl 

fit <- stl(y, s.window = "periodic")
fc <- forecast(fit, h=4)
plot(fc, main = "stl Forecasts")

mean(100-100*abs(as.numeric(fc$mean)-as.numeric(z_ts))/as.numeric(z_ts))


#########################
# Australian wine sales #
#########################

# par(mfrow=c(3,1))


wine.dat <- read.csv("C:/Users/kykim/Documents/Fast_Campus_Online/TS_Online/Ch_2/wine.csv")


### Modeling set & Test set  

wine_ms <- wine.dat$sweetw[1:175] # modeling set
wine_ts <- wine.dat$sweetw[176:187] # test set 

y <- ts(wine_ms, frequency=12) # modeling set frequency = 12 

# Exponential Moving Average

fit <- HoltWinters(y, beta=FALSE, gamma=FALSE) # Exp.MA learning
fc <- forecast(fit, h=4)  
plot(fc, main = "Exponential Moving Average Forecasts")

mean(100-100*abs(as.numeric(fc$mean)-as.numeric(wine_ts))/as.numeric(wine_ts))


# Holt-Winters

fit <- hw(y)
fc <- forecast(fit, h=4)
plot(fc, main = "Holt-Winters Forecasts")

mean(100-100*abs(as.numeric(fc$mean)-as.numeric(wine_ts))/as.numeric(wine_ts))

# stl

fit <- stl(y, s.window = "periodic")
fc <- forecast(fit, h=4)
plot(fc, main = "stl Forecasts")

mean(100-100*abs(as.numeric(fc$mean)-as.numeric(wine_ts))/as.numeric(wine_ts))


# multi-ts fcst

fcst_wine <- list() # list 

for(i in 2:7){
  ts1 <- wine.dat[,i] 
  ts2 <- ts(ts1, frequency = 12)  
  fit <- stl(ts2, s.window = "periodic") 
  fc <- forecast(fit, h=12) 
  fcst_wine[[i]] <- fc$mean 
}



#############################
# Goldman Sachs Stock Price #
#############################


gs <- read.csv("C:/Users/kykim/Documents/Fast_Campus_Online/TS_Online/Ch_2/gs_ts.csv")

#  Modeling set & Test set  

gs_ms <- gs$price[1:4613] # modeling set
gs_ts <- gs$price[4614:4633] # test set 

y <- ts(gs_ms, frequency=250) # modeling set

# par(mfrow=c(3,1))

# Exponential Moving Average

fit <- HoltWinters(y, beta=FALSE, gamma=FALSE) 
fc1 <- forecast(fit, h=20)  
plot(fc1, main = "Exponential Moving Average Forecasts") 

mean(100-100*abs(as.numeric(fc1$mean)-as.numeric(gs_ts))/as.numeric(gs_ts))

# Holt-Winters 

fit <- hw(y)
fc2 <- forecast(fit, h=20)
plot(fc2, main = "Holt-Winters Forecasts")

mean(100-100*abs(as.numeric(fc2$mean)-as.numeric(gs_ts))/as.numeric(gs_ts))


# stl 

fit <- stl(y, s.window = "periodic")
fc3 <- forecast(fit, h=20)
plot(fc3, main = "stl Forecasts")

mean(100-100*abs(as.numeric(fc3$mean)-as.numeric(gs_ts))/as.numeric(gs_ts))


as.data.frame(cbind(gs_ts, fc1$mean, fc2$mean, fc3$mean))
