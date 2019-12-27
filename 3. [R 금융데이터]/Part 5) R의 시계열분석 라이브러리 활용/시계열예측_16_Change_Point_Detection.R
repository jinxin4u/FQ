
library(changepoint)

## simulated example

y_ts    <- ts(rnorm(500,mean=1,sd=.5)) # random signal without a changepoint
y_ts_CP <- ts(c(rnorm(250,mean=1,sd=.5), rnorm(250,mean=2,sd=1))) # rand signal w\ changepoint

par(mfrow=c(2,1))
plot(y_ts)
plot(y_ts_CP)


mvalue <- cpt.mean(y_ts, method = "PELT") 
cpts(mvalue)
plot(mvalue)

mvalue <- cpt.mean(y_ts_CP, method = "PELT") 
cpts(mvalue)
plot(mvalue)

mvalue <- cpt.mean(y_ts_CP, method = "BinSeg")
cpts(mvalue)
plot(mvalue)


varvalue <- cpt.var(y_ts_CP, method = "PELT") 
cpts(varvalue)
plot(varvalue)

##### goldman sachs data

gs <- read.csv("C:/Users/kykim/Documents/Fast_Campus_Online/TS_Online/Ch_5/gs_ts.csv", header=T)
gs_ts <- ts(gs$price, frequency = 250)

mvalue <- cpt.mean(gs_ts, method = "PELT") 
cpts(mvalue)
plot(mvalue)


varvalue <- cpt.var(gs_ts, method = "PELT") 
cpts(varvalue)
plot(varvalue)


mvalue <- cpt.mean(gs_ts, method = "BinSeg") 
cpts(mvalue)
plot(mvalue)


varvalue <- cpt.var(gs_ts, method = "BinSeg") 
cpts(varvalue)
plot(varvalue)

mvalue <- cpt.mean(gs_ts, method = "AMOC") 
cpts(mvalue)
plot(mvalue)


varvalue <- cpt.var(gs_ts, method = "AMOC") 
cpts(varvalue)
plot(varvalue)

