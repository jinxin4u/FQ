

###############################
# Regression with ARIMA error #
###############################

library(forecast)
library(tseries)

# Sales data

sales_data <- read.csv("C:/Users/kykim/Documents/Fast_Campus_Online/TS_Online/Ch_4/ts_reg_s1.csv", header = T)

head(sales_data)

ts.plot(sales_data$Sales)

# training & test set 

sales_train <- sales_data[1:89,]
sales_test <- sales_data[90:96,]


##############
# Regression #
##############

sales_lm <- lm(Sales~Open+Promo+SchoolHoliday, data = sales_train)

summary(sales_lm)

# Residual Analysis

ts.plot(as.numeric(sales_lm$residuals))

library(lmtest)

attributes(sales_lm)

dwtest(sales_lm)

# prediction

covariates <- c("Open", "Promo", "SchoolHoliday")
sales_lm_fcst <- predict(sales_lm, newdata = sales_test[ ,covariates])

cbind(floor(sales_lm_fcst), sales_test$Sales)

# 1-MAPE

# mean(100-100*abs(as.numeric(sales_lm_fcst)-as.numeric(sales_test$Sales+1))/as.numeric(sales_test$Sales+1))
mean(100-100*abs(as.numeric(sales_lm_fcst[-4])-as.numeric(sales_test$Sales[-4]))/as.numeric(sales_test$Sales)[-4])




#########
# ARIMA #
#########

# Time Series Object 
sales_train <- ts(sales_train, frequency = 7)

# arima modeling
sales_fit1 <- auto.arima(sales_train[,"Sales"])

# forecast
sales_fcst1 <- forecast(sales_fit1, h = 7)

# 1-MAPE
mean(100-100*abs(as.numeric(sales_fcst1$mean[-4])-as.numeric(sales_test$Sales[-4]))/as.numeric(sales_test$Sales)[-4])


################################
# Regression with ARIMA errors #
################################

# ARIMA + Regression
covariates <- c("Open", "Promo", "SchoolHoliday")
sales_fit2 <- auto.arima(sales_train[,"Sales"], xreg = sales_train[, covariates])


# fcsts by Regression with ARIMA error (ARIMA + Regression)
sales_fcst2 <- forecast(sales_fit2, xreg = sales_test[, covariates])

# Regression with ARIMA error 
mean(100-100*abs(as.numeric(sales_fcst2$mean[-4])-as.numeric(sales_test$Sales[-4]))/as.numeric(sales_test$Sales)[-4])















