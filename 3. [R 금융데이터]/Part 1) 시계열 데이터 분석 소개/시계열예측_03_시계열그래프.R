
##########################################################
install.packages(forecast)
install.packages(ggplot2)
install.packages(ggfortify)
library(ggfortify)
library(forecast)
library(ggplot2)
##########################################################

####################################
# Lecture 03. Plotting Time Series #
####################################

# AirPassenger Data

plot(AirPassengers)

AP <- AirPassengers

par(mfrow=c(2,1))
plot(aggregate(AP), ylab = "Passengers")
boxplot(AP~cycle(AP), ylab = "Passengers")

# ts plot : plot( )

data(AirPassengers)
AP <- AirPassengers

class(AP)

start(AP);end(AP);frequency(AP) 

summary(AP)

plot(AP, ylab="Number of Passengers", xlab="Time")

# ts plot : ts.plot( )

USunemp <- read.csv("C:/Users/kykim/Documents/Fast_Campus_Online/TS_Online/Ch_1/USunemp.csv")

class(USunemp)

ts.plot(USunemp) # (or) ts.plot(USunemp$USun)

# Transform data frame into ts 
# then use plot( )

USunemp <- ts(USunemp, frequency = 12)

plot(USunemp, ylab = "Unemployed(%)")


# ggplot2

library(ggplot2)
library(ggfortify)

autoplot(AP)
autoplot(AirPassengers, ts.colour = 'red', ts.linetype = 'dashed')


# CBE data

CBE <- read.csv("C:/Users/kykim/Documents/Fast_Campus_Online/TS_Online/Ch_1/cbe.csv", header=T)

class(CBE) 

Choc.ts <- ts(CBE[,1], start = 1958, frequency = 12) 
Beer.ts <- ts(CBE[,2], start = 1958, frequency = 12)
Elec.ts <- ts(CBE[,3], start = 1958, frequency = 12)

plot(cbind(Elec.ts, Beer.ts, Choc.ts), main = "Multiple Time Series plots") 


##############################################################################
################### Intersection between time series #########################
##############################################################################

AP.elec <- ts.intersect(AP, Elec.ts)

start(AP.elec)
end(AP.elec)

par(mfrow=c(2,1))
plot(AP.elec[,1], ylab ="AirPassengers")
plot(AP.elec[,2], ylab = "Electricity")

plot(cbind(AP.elec[,1], AP.elec[,2]), main = "Multiple Time Series plots")
