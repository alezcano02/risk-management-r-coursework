#Forecast prices by using ARIMA - Autoarima
#Lest's do this for 1 asset: GLD (Gold ETF)
if(!require('quantmod')) install.packages('quantmod');library(quantmod)
stockEnv <- new.env()
start <- Sys.Date()-365
end <- Sys.Date()
ticker <- 'GLD'
getSymbols(Symbols = ticker,
           env=stockEnv,
           from=start,
           to=end)
head(stockEnv$GLD)
tail(stockEnv$GLD)

data <- stockEnv$GLD$GLD.Adjusted
library(ggplot2)
ggplot(fortify(data),aes(x=Index,y=GLD.Adjusted))+geom_line()+labs(x='Date',y='GLD ETF Prices',title='GLD ETF price development')
#same but quantmod
chartSeries(data,type='bars',theme='white',main='GLD ETF price development')
if(!require('tseries')) install.packages('tseries');library(tseries)
#Check stationary 
adf.test(data$GLD.Adjusted)

#use acf - auto-correlation
acf(data$GLD.Adjusted)

#convert to stationary
log_ret <- diff(log(data$GLD.Adjusted),lag=1)
data$log_ret <- log_ret
head(data)
#get rid of na
data<- na.omit(data)

#plot log returns
ggplot(data,aes(x=Index,y=log_ret))+geom_line()+labs(x='Date',y='Log GLD ETF',title='Log Returns')

#1st order differenciating
data_dif <- diff(data$GLD.Adjusted)
data$adj_dif <- data_dif
data <- na.omit(data)
head(data)

#adf
adf.test(data$adj_dif)
#acf again
acf(data$adj_dif)
#pacf
pacf(data$adj_dif)

#Now use ARIMA
if(!require('forecasr')) install.packages('forecast'); library(forecast)
model_arima <- auto.arima(data$adj_dif,seasonal=FALSE)
model_arima #0,0,0

#lets check
model1_arima <- auto.arima(data$GLD.Adjusted,seasonal=FALSE)
model1_arima #0,1,0

#lets implement(0,1,0)
model <- Arima(data$GLD.Adjusted,order=c(0,1,0),include.constant = TRUE)
model
 
#check residuals
checkresiduals(model)

#forecast
arima_forecast <- forecast(model,level=99)
summary(arima_forecast)

