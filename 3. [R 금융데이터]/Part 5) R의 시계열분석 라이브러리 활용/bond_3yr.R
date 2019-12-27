
library(dplyr)
library(forecast)


bond <- read.csv("C:/Users/kykim/Documents/Fast_Campus_Online/TS_Online/Ch_5/bond_3yr.csv", header=T)

bond$date <- as.Date(bond$date , format = "%Y/%m/%d")

# bond1 <- filter(bond, date>="2017-06-01")


bond1 <- bond

bond1 <- bond1[complete.cases(bond1), ]

# dim(filter(gs, date>="2012-01-01" & date <= "2012-12-31"))


bond_ms <- bond1$rate[1:(nrow(bond1)-30)]
bond_ts <- bond1$rate[(nrow(bond1)-29):nrow(bond1)]



## stl


fit <- stl(ts(bond_ms, frequency = 250), s.window = "per")
fcst <- as.numeric(forecast(fit, h = 30)$mean)

mean(100-100*abs(fcst-bond_ts)/bond_ts)

ts.plot(bond_ts)
lines(fcst, col = "red")



## tbats


fit <- tbats(ts(bond_ms, frequency = 250))
fcst <- as.numeric(forecast(fit, h = 30)$mean)

mean(100-100*abs(fcst-bond_ts)/bond_ts)

ts.plot(bond_ts)
lines(fcst, col = "red")

## arima


fit <- auto.arima(ts(bond_ms, frequency = 250))
fcst <- as.numeric(forecast(fit, h = 30)$mean)

mean(100-100*abs(fcst-bond_ts)/bond_ts)

ts.plot(bond_ts, ylim=c(0,2))
lines(fcst, col = "red")


## neural network


fit <- nnetar(ts(bond_ms, frequency = 250))
fcst <- as.numeric(forecast(fit, h = 30)$mean)

mean(100-100*abs(fcst-bond_ts)/bond_ts)

ts.plot(bond_ts, ylim=c(0,2))
lines(fcst, col = "red")


