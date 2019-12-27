
################################
# Time Series Modeling Summary #
################################

# 1. Time Sereis Decomposition : Holt-Winters, STL
# 2. ARIMA


# Loading required package #   

library(forecast)
library(tseries)

########
# Data #
########

USunemp <- read.csv("C:/Users/kykim/Documents/Fast_Campus_Online/TS_Online/Ch_3/USunemp.csv", header = T)

head(USunemp)

# Time Series Plot 

ts.plot(USunemp$USun)

dim(USunemp) 


###########################################################
# modeling set & test set for forecasting 12 months ahead #
###########################################################
# Time Series Cross Validation

# modeling set 1 
# Test Set 1 : Most Recent 12 data points

ms_1 <- USunemp$USun[1:118]
ts_1 <- USunemp$USun[119:130]

# modeling set 2 
# Test Set 1 : Next Recent 12 data points

ms_2 <- USunemp$USun[1:106]
ts_2 <- USunemp$USun[107:118]

# modeling set 3 
# Test Set 1 : Most Recent 12 data points

ms_3 <- USunemp$USun[1:94]
ts_3 <- USunemp$USun[95:106]

# Transform modeling set to Time Series Object in R

ms_1 <- ts(ms_1, frequency = 12) 
ms_2 <- ts(ms_2, frequency = 12) 
ms_3 <- ts(ms_3, frequency = 12) 


#######################
# Holt-Winters Method #
#######################

hw_1 <- hw(ms_1) 
hw_2 <- hw(ms_2)
hw_3 <- hw(ms_3)

hw_1_fcst <- forecast(hw_1, h=12)  
hw_2_fcst <- forecast(hw_2, h=12)
hw_3_fcst <- forecast(hw_3, h=12)

attributes(hw_1_fcst)

cbind(hw_1_fcst$mean, ts_1)


par(mfrow=c(3,1))
plot(hw_1_fcst, main = "Forecasts with Trend & Seasonality : Holt-Winters")
plot(hw_2_fcst, main = "Forecasts with Trend & Seasonality : Holt-Winters")
plot(hw_3_fcst, main = "Forecasts with Trend & Seasonality : Holt-Winters")

# 1-MAPE

100-100*mean(abs(hw_1_fcst$mean-ts_1)/ts_1)
100-100*mean(abs(hw_2_fcst$mean-ts_2)/ts_2)
100-100*mean(abs(hw_3_fcst$mean-ts_3)/ts_3)


##############
# STL Method #
##############

stl_1 <- stl(ms_1, s.window = "per") 
stl_2 <- stl(ms_2, s.window = "per")
stl_3 <- stl(ms_3, s.window = "per")

stl_1_fcst <- forecast(stl_1, h=12)  
stl_2_fcst <- forecast(stl_2, h=12)
stl_3_fcst <- forecast(stl_3, h=12)

attributes(hw_1_fcst)

cbind(stl_1_fcst$mean, ts_1)

par(mfrow=c(3,1))
plot(stl_1_fcst, main = "Forecasts with Trend & Seasonality : STL")
plot(stl_2_fcst, main = "Forecasts with Trend & Seasonality : STL")
plot(stl_3_fcst, main = "Forecasts with Trend & Seasonality : STL")

# 1-MAPE

100-100*mean(abs(stl_1_fcst$mean-ts_1)/ts_1)
100-100*mean(abs(stl_2_fcst$mean-ts_2)/ts_2)
100-100*mean(abs(stl_3_fcst$mean-ts_3)/ts_3)




#########
# ARIMA #
#########


arima_1 <- auto.arima(ms_1) 
arima_2 <- auto.arima(ms_2) 
arima_3 <- auto.arima(ms_3) 


arima_1_fcst <- forecast(arima_1, h=12)  
arima_2_fcst <- forecast(arima_2, h=12)  
arima_3_fcst <- forecast(arima_3, h=12)  

attributes(arima_1_fcst)

cbind(arima_1_fcst$mean, ts_1)

par(mfrow=c(3,1))
plot(arima_1_fcst, main = "Forecasts with ARIMA")
plot(arima_2_fcst, main = "Forecasts with ARIMA")
plot(arima_3_fcst, main = "Forecasts with ARIMA")

# 1-MAPE

100-100*mean(abs(arima_1_fcst$mean-ts_1)/ts_1)
100-100*mean(abs(arima_2_fcst$mean-ts_2)/ts_2)
100-100*mean(abs(arima_3_fcst$mean-ts_3)/ts_3)



