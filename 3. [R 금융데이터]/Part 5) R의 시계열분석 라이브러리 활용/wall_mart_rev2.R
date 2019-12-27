
library(dplyr)
library(forecast)


wm <- read.csv("C:/Users/kykim/Documents/Fast_Campus_Online/TS_Online/Ch_5/wm_ts.csv", header=T) %>%
  mutate(price = log(price))


wm_ms <- wm$price[1:(nrow(wm)-30)]
wm_ts <- wm$price[(nrow(wm)-29):nrow(wm)]


## stl


fit <- stl(ts(wm_ms, frequency = 250), s.window = "per")
fcst <- as.numeric(forecast(fit, h = 30)$mean)

# MAPE

mean(100-100*abs( (exp(fcst)-exp(wm_ts)) / exp(wm_ts) ))


# plot

ts.plot(exp(wm_ts))
lines(exp(fcst), col = "red")

ts.plot(exp(wm_ts), ylim=c(75, 85))
lines(exp(fcst), col = "red")



## tbats

fit <- tbats(ts(wm_ms, fr=250))
fcst <- as.numeric(forecast(fit, h = 30)$mean)

# MAPE

mean(100-100*abs( (exp(fcst)-exp(wm_ts)) / exp(wm_ts) ))


# plot

ts.plot(exp(wm_ts))
lines(exp(fcst), col = "red")

ts.plot(exp(wm_ts), ylim=c(75, 85))
lines(exp(fcst), col = "red")


## arima

# fit
z <- fourier(ts(wm_ms, fr=250), K= 7)
zreg <- fourier(ts(wm_ms, fr=250), K= 7, h = 30)

fit <- auto.arima(ts(wm_ms, fr=5), seasonal=FALSE, xreg= z)
fcst <- as.numeric(forecast(fit, xreg = zreg, h = 30)$mean)

# MAPE

mean(100-100*abs( (exp(fcst)-exp(wm_ts)) / exp(wm_ts) ))


# plot

ts.plot(exp(wm_ts))
lines(exp(fcst), col = "red")

ts.plot(exp(wm_ts), ylim=c(75, 85))
lines(exp(fcst), col = "red")

## neural network

fit <- nnetar(ts(wm_ms, frequency = 250))
fcst <- as.numeric(forecast(fit, h = 30)$mean)

# MAPE

mean(100-100*abs( (exp(fcst)-exp(wm_ts)) / exp(wm_ts) ))


# plot

ts.plot(exp(wm_ts))
lines(exp(fcst), col = "red")

ts.plot(exp(wm_ts), ylim=c(75, 85))
lines(exp(fcst), col = "red")


#######################################################################################
## prophet

library(dplyr)
library(prophet)


df <- read.csv("C:/Users/kykim/Documents/Fast_Campus_Online/TS_Online/Ch_5/wm_ts.csv", header=T) %>%
  mutate(price = log(price))
df <- df[,1:2] 

#

df_ms <- df[1:(nrow(df)-30),]
colnames(df_ms) <- c("ds", "y")
df_ts <- df[(nrow(df)-29):nrow(df),]

m <- prophet(df_ms)

# forecasting

future <- make_future_dataframe(m, periods = 30)
tail(future)

forecast <- predict(m, future)
tail(forecast[c('ds', 'yhat', 'yhat_lower', 'yhat_upper')])

plot(m, forecast)

# plot for trend & weeekly/yearly seasonality

prophet_plot_components(m, forecast)

# MAPE

yhat <- exp(forecast$yhat[(11374-29):11374])

mean(100-100*abs(as.numeric(yhat)-as.numeric(exp(df_ts$price)))/as.numeric(exp(df_ts$price)))

# fcst plot

ts.plot(exp(df_ts$price), ylim=c(75, 85))
lines(yhat, col = "red")

#######################################################################################

############## volume 



