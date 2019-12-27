
##########################################################
install.packages(forecast)
install.packages(ggplot2)
library(forecast)
library(ggplot2)
##########################################################

#####################################
# Lecture 02. Time Series Data at R #
#####################################

# Reading .csv (data)

read.csv("C:/Users/kykim/Documents/Fast_Campus_Online/TS_Online/Ch_1/USunemp.csv")

USunemp <- read.csv("C:/Users/kykim/Documents/Fast_Campus_Online/TS_Online/Ch_1/USunemp.csv")

# check if USunemp is ts

class(USunemp)

# tranform data frame into ts 

USunemp <- ts(USunemp)

class(USunemp)