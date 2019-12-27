

###############################################################
# Time Series with Multi-Seasonality : Seoul Metro Daily Data #
###############################################################

library(forecast)
library(tseries)

#### data preparation

metro <- read.csv("C:/Users/kykim/Documents/Fast_Campus_Online/TS_Online/Ch_4/seoul_metro.csv", header = T)
city <- metro$CityHall

ts.plot(city)


#### forecasting 14 days

city_train <- city[1:1812]
city_test <- city[1813:1826]


##### tbats with multi-Seasonality

city_ts <- ts(city_train, frequency = 7)
city_msts <- msts(city_train, seasonal.periods = c(7, 365)) 

tbats_ts <- tbats(city_ts)
tbats_msts <- tbats(city_msts)


fcst_ts <- forecast(tbats_ts, h = 14)
fcst_msts <- forecast(tbats_msts, h = 14)

plot(fcst_ts)

mean(100-100*abs(as.numeric(fcst_ts$mean)-as.numeric(city_test))/as.numeric(city_test))
mean(100-100*abs(as.numeric(fcst_msts$mean)-as.numeric(city_test))/as.numeric(city_test))


# forecasting 365 days 

city_train2 <- city[1:1461]
city_test2 <- city[1462:1826]


city_ts_2 <- ts(city_train2, frequency = 7)
city_msts_2 <- msts(city_train2, seasonal.periods = c(7, 365)) 
city_msts2_2 <- msts(city_train2, seasonal.periods = c(7, 30, 365)) 

tbats_ts_2 <- tbats(city_ts_2)
tbats_msts_2 <- tbats(city_msts_2)
tbats_msts2_2<- tbats(city_msts2_2)

fcst_ts_2 <- forecast(tbats_ts_2, h = 365)
fcst_msts_2 <- forecast(tbats_msts_2, h = 365)
fcst_msts2_2 <- forecast(tbats_msts2_2, h = 365)


mean(100-100*abs(as.numeric(fcst_ts_2$mean)-as.numeric(city_test2))/as.numeric(city_test2))
mean(100-100*abs(as.numeric(fcst_msts_2$mean)-as.numeric(city_test2))/as.numeric(city_test2))
mean(100-100*abs(as.numeric(fcst_msts2_2$mean)-as.numeric(city_test2))/as.numeric(city_test2))


# auto.arima with Fourier Seasonality

city_train3 <- city[1:1461]
city_test3 <- city[1462:1826]

city_msts_3 <- msts(city_train3, seasonal.periods = c(7, 365))


z <- fourier(city_msts_3, K=c(3, 10))
zreg <- fourier(city_msts_3, K=c(3, 10), h = 365)

arima_msts <- auto.arima(city_msts_3, seasonal=FALSE, xreg= z)


fcst_msts_3 <- forecast(arima_msts, xreg = zreg, h = 365)

mean(100-100*abs(as.numeric(fcst_msts_3$mean)-as.numeric(city_test3))/as.numeric(city_test3))

