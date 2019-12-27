
library(dplyr)
library(forecast)


gs <- read.csv("C:/Users/kykim/Documents/Fast_Campus_Online/TS_Online/Ch_5/gs_ts.csv", header=T) %>% 
  mutate(price=log(price))


gs_ms <- gs$price[1:(nrow(gs)-30)]
gs_ts <- gs$price[(nrow(gs)-29):nrow(gs)]



## stl


fit <- stl(ts(gs_ms, frequency = 250), s.window = "per")
fcst <- as.numeric(forecast(fit, h = 30)$mean)

# MAPE

mean(100-100*abs( (exp(fcst)-exp(gs_ts)) / exp(gs_ts) ))


# plot

ts.plot(exp(gs_ts))
lines(exp(fcst), col = "red")

ts.plot(exp(gs_ts), ylim=c(200, 250))
lines(exp(fcst), col = "red")



## tbats


# fit <- tbats(msts(gs_ms, seasonal.periods=c(5,250)))
fit <- tbats(ts(gs_ms, fr=250))
fcst <- as.numeric(forecast(fit, h = 30)$mean)


# MAPE

mean(100-100*abs( (exp(fcst)-exp(gs_ts)) / exp(gs_ts) ))


# plot

ts.plot(exp(gs_ts))
lines(exp(fcst), col = "red")

ts.plot(exp(gs_ts), ylim=c(200, 250))
lines(exp(fcst), col = "red")



## arima

# fit
z <- fourier(ts(gs_ms, fr=250), K= 10)
zreg <- fourier(ts(gs_ms, fr=250), K= 10, h = 30)

fit <- auto.arima(ts(gs_ms, fr=5), seasonal=FALSE, xreg= z)
fcst <- as.numeric(forecast(fit, xreg = zreg, h = 30)$mean)


# MAPE

mean(100-100*abs( (exp(fcst)-exp(gs_ts)) / exp(gs_ts) ))


# plot

ts.plot(exp(gs_ts))
lines(exp(fcst), col = "red")

ts.plot(exp(gs_ts), ylim=c(0, 250))
lines(exp(fcst), col = "red")


## neural network

fit <- nnetar(ts(gs_ms, frequency = 250))
fcst <- as.numeric(forecast(fit, h = 30)$mean)

# MAPE

mean(100-100*abs( (exp(fcst)-exp(gs_ts)) / exp(gs_ts) ))


# plot

ts.plot(exp(gs_ts))
lines(exp(fcst), col = "red")

ts.plot(exp(gs_ts), ylim=c(200, 250))
lines(exp(fcst), col = "red")


#######################################################################################
## prophet

library(prophet)
library(dplyr)

df <- read.csv("C:/Users/kykim/Documents/Fast_Campus_Online/TS_Online/Ch_5/gs_ts.csv", header=T) %>% 
  mutate(price = log(price))

df <- gs[,1:2] 


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

yhat <- exp(forecast$yhat[(4633-29):4633])

mean(100-100*abs(as.numeric(yhat)-as.numeric(exp(df_ts$price)))/as.numeric(exp(df_ts$price)))

# fcst plot

ts.plot(exp(df_ts$price), ylim=c(200, 250))
lines(yhat, col = "red")

#######################################################################################




