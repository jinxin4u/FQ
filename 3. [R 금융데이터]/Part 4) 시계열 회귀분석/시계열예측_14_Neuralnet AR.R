# package loading   

library(forecast)
library(tseries)


# sales_s1 

sales_s1 <- read.csv("C:/Users/kykim/Documents/Fast_Campus_Online/TS_Online/Ch_4/sales_s1.csv", header = T)


head(sales_s1)

# ts.plot  

par(mfrow=c(3,1))
ts.plot(sales_s1$site1)
ts.plot(sales_s1$site2)
ts.plot(sales_s1$total)

dim(sales_s1) # sales for 1127 days 


par(mfrow=c(3,1))
ts.plot(sales_s1$site1[1000:1127])
ts.plot(sales_s1$site2[1000:1127])
ts.plot(sales_s1$total[1000:1127])


# data 1 : modeling set: 2014/01/01~2017/01/03, test set: 2017/01/04~2017/01/31

ms_t1 <- sales_s1$total[1:1099]
ts_t1 <- sales_s1$total[1100:1127]

# data 2 : modeling set: 2014/01/01~2016/12/04, test set: 2016/12/05~2017/01/31

ms_t2 <- sales_s1$total[1:1069]
ts_t2 <- sales_s1$total[1070:1097]

# data 3 : modeling set: 2014/01/01~2016/11/04, test set: 2016/11/05~2017/01/31

ms_t3 <- sales_s1$total[1:1039]
ts_t3 <- sales_s1$total[1040:1067]

# frequency = 365

ms_t1 <- ts(ms_t1, frequency = 365) # single seasonality
ms_t2 <- ts(ms_t2, frequency = 365) # single seasonality
ms_t3 <- ts(ms_t3, frequency = 365) # single seasonality




# neural network AR with seasonality 

t1_nnetar <- nnetar(ms_t1) 
t2_nnetar <- nnetar(ms_t2) 
t3_nnetar <- nnetar(ms_t3) 


nnetar_fc1 <- forecast(t1_nnetar, h=28) 
nnetar_fc2 <- forecast(t2_nnetar, h=28)  
nnetar_fc3 <- forecast(t3_nnetar, h=28)  



# fcst < 0 -> 0

nnetar_fc1$mean[nnetar_fc1$means<0] <- 0 
nnetar_fc2$mean[nnetar_fc2$means<0] <- 0 
nnetar_fc3$mean[nnetar_fc3$means<0] <- 0 
 

# plot

plot(nnetar_fc1, main = "Forecasts with Neural Network")
plot(nnetar_fc1, main = "Forecasts with Neural Network")
plot(nnetar_fc1, main = "Forecasts with Neural Network")

# 1-MAPE

100-100*(abs(sum(nnetar_fc1$mean)-(sum(ts_t1)))/(sum(ts_t1)))
100-100*(abs(sum(nnetar_fc2$mean)-(sum(ts_t2)))/(sum(ts_t2)))
100-100*(abs(sum(nnetar_fc3$mean)-(sum(ts_t3)))/(sum(ts_t3)))

