


library(prophet)
library(dplyr)



#################################################################################################

df <- read.csv("C:/Users/kykim/Documents/Fast_Campus_Online/TS_Online/Ch_5/example_wp_peyton_manning.csv")

# import data set and apply log-transformation
df <- read.table('C:/Users/kykim/Documents/Fast_Campus_Online/TS_Online/Ch_5/example_wp_peyton_manning.csv', 
                 sep=",", header=T) %>% 
  mutate(y = log(y))

# training & test set]

df_ms <- df[1:2540,]
df_ts <- df[2541:2905,]


# fitting model

m <- prophet(df_ms)

# forecasting

future <- make_future_dataframe(m, periods = 365)
tail(future)

forecast <- predict(m, future)
tail(forecast[c('ds', 'yhat', 'yhat_lower', 'yhat_upper')])

# plot

plot(m, forecast)

# plot for trend & weeekly/yearly seasonality

prophet_plot_components(m, forecast)

# MAPE

yhat <- exp(forecast$yhat[(2905-364):2905])

mean(100-100*abs(as.numeric(yhat)-as.numeric(exp(df_ts$y)))/as.numeric(exp(df_ts$y)))




#################################################################################################
# Saturating Maximum
#################################################################################################


# import data set and apply log-transformation

df <- read.table('C:/Users/kykim/Documents/Fast_Campus_Online/TS_Online/Ch_5/example_wp_R.csv', 
                 sep=",", header=T) %>% 
  
  mutate(y = log(y))

df$cap <- 8.5

m <- prophet(df, growth = 'logistic')

future <- make_future_dataframe(m, periods = 1826)
future$cap <- 8.5
fcst <- predict(m, future)
plot(m, fcst);



#################################################################################################
# Saturating Minimum
#################################################################################################

# import data set and apply log-transformation

df <- read.table('C:/Users/kyongryun/Documents/TS2/prophet/example_wp_R.csv', 
                 sep=",", header=T) %>% 
  
  mutate(y = log(y))

df$y <- 10 - df$y
df$cap <- 6
df$floor <- 1.5
future$cap <- 6
future$floor <- 1.5
m <- prophet(df, growth = 'logistic')
fcst <- predict(m, future)
plot(m, fcst)


#################################################################################################
# adding seasonality (or replace weekly by monthly)
#################################################################################################

# import data set and apply log-transformation

df <- read.table("C:/Users/kykim/Documents/Fast_Campus_Online/TS_Online/Ch_5/example_wp_peyton_manning.csv", 
                 sep=",", header=T) %>% 
  
  mutate(y = log(y))

m <- prophet(weekly.seasonality=FALSE)
m <- add_seasonality(m, name='monthly', period=30.5, fourier.order=5)
m <- fit.prophet(m, df)
future <- make_future_dataframe(m, periods = 365)
forecast <- predict(m, future)
prophet_plot_components(m, forecast)


#################################################################################################
# holiday effects
#################################################################################################

# import data set and apply log-transformation

df <- read.table('C:/Users/kykim/Documents/Fast_Campus_Online/TS_Online/Ch_5/example_wp_peyton_manning.csv', 
                 sep=",", header=T) %>% 
  
  mutate(y = log(y))

m <- prophet(weekly.seasonality=FALSE)
m <- add_seasonality(m, name='monthly', period=30.5, fourier.order=5)
m <- fit.prophet(m, df)
future <- make_future_dataframe(m, periods = 365)
forecast <- predict(m, future)
prophet_plot_components(m, forecast)

# make holidays data

library(dplyr)
playoffs <- data_frame(
  holiday = 'playoff',
  ds = as.Date(c('2008-01-13', '2009-01-03', '2010-01-16',
                 '2010-01-24', '2010-02-07', '2011-01-08',
                 '2013-01-12', '2014-01-12', '2014-01-19',
                 '2014-02-02', '2015-01-11', '2016-01-17',
                 '2016-01-24', '2016-02-07')),
  lower_window = 0,
  upper_window = 1
)
superbowls <- data_frame(
  holiday = 'superbowl',
  ds = as.Date(c('2010-02-07', '2014-02-02', '2016-02-07')),
  lower_window = 0,
  upper_window = 1
)
holidays <- bind_rows(playoffs, superbowls)

# add holiday variable & fitting a model + forecasting

m <- prophet(df, holidays = holidays)
forecast <- predict(m, future)

# display holiday effects

forecast %>% 
  select(ds, playoff, superbowl) %>% 
  filter(abs(playoff + superbowl) > 0) %>%
  tail(10)

# components plot for holiday effects

prophet_plot_components(m, forecast);


# cross-validation


df <- read.table('C:/Users/kykim/Documents/Fast_Campus_Online/TS_Online/Ch_5/example_wp_peyton_manning.csv', sep=",", header=T) %>% 
  mutate(y = log(y))

m <- prophet(df)

df.cv <- cross_validation(m, horizon = 365, units = 'days')
head(df.cv)

df.cv$cutoff <- as.Date(df.cv$cutoff)  # 'POSIXct' format -> 'Date' format
unique(df.cv$cutoff) # view cutoffs
filter(df.cv, cutoff=="2011-01-19") # view a forecst for specific Date

