##########################################################
install.packages(forecast)
install.packages(ggplot2)
library(forecast)
library(ggplot2)
##########################################################

##################
# Moving Average #
##################

# read data "Goldman Sachs Stock Price"

gs <- read.csv("C:/Users/kykim/Documents/Fast_Campus_Online/TS_Online/Ch_2/gs_ts.csv")

head(gs)
tail(gs)

# TS object 

gs_price <- ts(gs$price, frequency = 250)

plot(gs_price, main = "Goldman Sachs Stock Price")

# Moving Average 

plot(gs_price, main = "Goldman Sachs Stock Price: 100days MA")

m1 <- filter(gs_price, rep(1/100,100), sides=1) 
lines(m1, col = "red")

# Exponentail Moving Average : HoltWinters

gs_hw <- HoltWinters(gs_price, beta=FALSE, gamma=FALSE)
plot(gs_hw, main = "Exponential Moving Average")


# Weight is fixed : HoltWinters

gs_exp <- HoltWinters(gs_price, alpha = 0.8, beta=FALSE, gamma=FALSE)
plot(gs_hw, main = "Exponential Moving Average")


