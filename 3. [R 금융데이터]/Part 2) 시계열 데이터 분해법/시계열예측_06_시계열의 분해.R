##########################################################
install.packages(forecast)
install.packages(ggplot2)
library(forecast)
library(ggplot2)
##########################################################



#############################
# Time Series Decomposition #
#############################


# read data "Goldman Sachs Stock Price"

gs <- read.csv("C:/Users/kykim/Documents/Fast_Campus_Online/TS_Online/Ch_2/gs_ts.csv")

# TS object 

gs_price <- ts(gs$price, frequency = 250)

# Decomposition Plot : Moving Average Trend

plot(decompose(gs_price))


################
# Holt-Winters #
################

gs_hw<- HoltWinters(gs_price)

plot(gs_hw)

forecast(gs_hw, h=10)

# Decomposition Plot

class(gs_hw)

is.list(gs_hw)

attributes(gs_hw)

str(gs_hw)

gs_hw_fitted <- gs_hw$fitted[,1:4]
colnames(gs_hw_fitted) <- cbind('xhat','Level','Trend','Seasonality')
plot(gs_hw_fitted, main = "Decompostion of time series")


# gs_hw <- HoltWinters(gs_price, beta = 0.5) 

# gs_hw_fitted <- gs_hw$fitted[,1:4]
# colnames(gs_hw_fitted) <- cbind('xhat','Level','Trend','Seasonality')
# plot(gs_hw_fitted, main = "Decompostion of time series")


###############
# STL : LOESS #
###############

gs_stl <- stl(gs_price, s.window = "periodic")

plot(gs_stl)


attributes(gs_stl)

gs_stl$time.series


gs_stl$time.series[,1] # 1st column = seasonality

stl_fcst <- forecast(gs_stl, h = 100)
plot(stl_fcst, main = "Forecast from STL")

