
##########################################################
install.packages(forecast)
install.packages(ggplot2)
library(forecast)
library(ggplot2)
##########################################################

###################################
# Lecture 04. Trend & Seasonality #
###################################

# AirPassenger Data

plot(AirPassengers)

AP <- AirPassengers

par(mfrow=c(2,1))
plot(aggregate(AP), ylab = "Passengers")
boxplot(AP~cycle(AP), ylab = "Passengers")
# dev.off()

class(AP) # check if AP is ts
cycle(AP) # check the frequency

aggregate(AP) # summation for every cycle

# Trend Plot

AP.time <- time(AP) # X-axis = time

Reg <- lm(AP~AP.time) # Regression

plot(AP)
abline(Reg)

# TS Decompsition

decompose(AP)
plot(decompose(AP))



