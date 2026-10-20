# CAPM
# = rf + beta * (Marketreturn -rf)
library(tidyverse)
library(quantmod)
tickers = c('AAPL', 'MSFT', 'GOOGL', 'AMZN', 'TSLA', 'SPY')

startDate = as.Date("2023-01-01")
endDate = as.Date("2024-01-01")

stockEnv =new.env()

getSymbols(Symbols=tickers,
           env=stockEnv,
           from=startDate,
           to=endDate)

# given by the task
data <- do.call("cbind", eapply(stockEnv, Cl))

# daily returns
returns <-  na.omit(ROC(data, type='discrete'))

# mean and cov
mean_returns <- colMeans(returns)
cov_matrix <- cov(returns)


# risk free rate
risk_free_rate <-  0.01

# expected returns via CAPM
market_return <- mean(mean_returns)
betas <- cov_matrix[ ,'SPY.Close'] / var(returns[ , 'SPY.Close'])
expected_returns <-  risk_free_rate + betas *(market_return -risk_free_rate)

# capm_results
capm_results <- data.frame(Expected_Return = expected_returns)

# print
print(capm_results)

# sort everything
recommendation <- capm_results %>% 
  arrange(desc(Expected_Return)) %>% 
  head(5)

# print(recommendation)
print(recommendation)

