library(tidyverse)
library(caret)
df <- read_csv('data/diabetes.csv')
head(df,3)
str(df)

# organize the data (so that it is "logit ready")

# here: get rid of the records with missing values
# i.e., take only the rows that are complete
df <- df[complete.cases(df), ]

# cast to factor (several columns in one go)
df <- df %>% 
  mutate_if(is.character, as.factor)

str(df)
# also cast Credit_History
df$Outcome <- as.factor(df$Outcome)
str(df)

# use caret
# partition the data
set.seed(4321)
d <- createDataPartition(df$Outcome, p=0.7, list=FALSE)
train <- df[d, ]
test <- df[-d, ]

# define the model: logit
logit <- train(form=Outcome~.,
               data=train,
               method='glm',
               preProcess = c('scale', 'center'),
               trControl=trainControl(method='cv', number = 5))


pred_LR <- predict(logit, newdata=test)
xtab_LR <- table(test$Outcome, pred_LR)
confusionMatrix(xtab_LR) #0.7739

library(readxl)
new <- read_excel('data/nuevoPaciente.xlsx')

pred <- predict(logit,new,type='response')
