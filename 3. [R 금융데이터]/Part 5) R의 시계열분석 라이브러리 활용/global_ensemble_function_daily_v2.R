
library(forecast)
# library(caret)


sales_s1 <- read.csv("C:/Users/kykim/Documents/Fast_Campus_Online/TS_Online/Ch_5/sales_s1.csv", header=T)

# training & test set]

sales_s1 <- sales_s1$total

sales_ms <- sales_s1[1:1097]
sales_ts <- sales_s1[1098:1127]

# options(warn=-1)
test1 <- ensemble_v1(sales_ms, 365.25, 7, 30)
# options(warn=0)


# fcst plot
ts.plot(sales_ts)
lines(as.numeric(test1[[2]]), col="red")

############################################################################
################### Global ensemble function ###############################
############################################################################


ensemble_v1 <- function(x, frq1, frq2, fh){

  
  
  r1 <- ensemble_test(x, frq1, frq2, fh)
  
  p1 <- which(r1==max(r1))
  
  qt = x

  y1 <- ts(qt, frequency = frq1)
  y2 <- msts(qt, seasonal.periods = c(frq1, frq2)) 
  
  if(p1 == 1){r2 <- forecast(stl(y1, s.window = "per"), h=fh)$mean}
    
  else if(p1 == 2){r2 <- forecast(tbats(y2), h=fh)$mean}
    
#  else if(p1 == 3){r2 <- forecast(auto.arima(y1), h=fh)$mean}
    
  else{r2 <- forecast(nnetar(y1), h=fh)$mean}  
  
  return(list(r1, r2))

}



##################################################################
############ Test Ensemble function for daily ###############
##################################################################



ensemble_test <- function(x, frq1, frq2, fcst_h){
  
  
  qt = x 
  len1 = length(qt)
  
  # qt_ms = qt[1:1099]
  # qt_ts = qt[1100:1127]
  
  qt_ms = qt[1:(len1-fcst_h)]
  qt_ts = qt[(len1-fcst_h+1):len1]
  
  y1 <- ts(qt_ms, frequency = frq1)
  y2 <- msts(qt_ms, seasonal.periods = c(frq1, frq2)) 

  # stl
  
  fc1 <- tryCatch(forecast(stl(y1, s.window = "per"), h=fcst_h), error=function(e) 0)
  
  # tbats
  
  fc2 <- tryCatch(forecast(tbats(y2), h=fcst_h), error=function(e) 0)
  
  # arima
  
#  fc3 <- tryCatch(forecast(auto.arima(y1), h=fcst_h), error=function(e) 0)
  
  # nnetar
  
  fc3 <- tryCatch(forecast(nnetar(y1), h=fcst_h), error=function(e) 0)
  
  
  ############### Calculate " MAPE " ################################################### 
  
  MAPEr <- c(0, 0, 0)
  
  # stl
  
  if(sum(is.list(fc1))==1){
    fc1$mean[fc1$mean<0]<-0
    MAPEr[1] <- 100-100*(abs(sum(fc1$mean)-(sum(qt_ts)))/(sum(qt_ts))) } else{MAPEr[1] <- 0}
  
  # tbats
  
  if(sum(is.list(fc2))==1){
    fc2$mean[fc2$mean<0]<-0
    MAPEr[2] <- 100-100*(abs(sum(fc2$mean)-(sum(qt_ts)))/(sum(qt_ts))) } else{MAPEr[2] <- 0}
  
  # neuralnet
  
  if(sum(is.list(fc3))==1){
    fc3$mean[fc3$mean<0]<-0
    MAPEr[3] <- 100-100*(abs(sum(fc3$mean)-(sum(qt_ts)))/(sum(qt_ts))) } else{MAPEr[3] <- 0}
  
  
  
  
  
  return(MAPEr)
  
}
