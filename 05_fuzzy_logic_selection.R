#Fuzzy logic
#The problem to solve: Selecction of a candidate depending on 3 variables
#We will apply rules for taking the decision 

if (!require('sets')) install.packages('sets');library(sets)
#set up 
sets_options("universe",seq(1,100,0.1))
variables <- set(
  exp=fuzzy_partition(varnames = c(little=30,acceptable=70,much=90), sd=5.0),
  edu=fuzzy_partition(varnames = c(little=30,acceptable=60,high=80), sd=3.0),
  car=fuzzy_partition(varnames = c(little=40,ok=60,high=90), sd=7.7),
  aptitude=fuzzy_partition(varnames = c(little=40,ok=65,perfect=80), FUN=fuzzy_cone,radius=10)
)

#fuzzy rules
rules <- set(
  fuzzy_rule(exp%is%acceptable&&edu%is%little&&car%is%little,aptitude%is%perfect),
  fuzzy_rule(exp%is%much&&edu%is%high&&car%is%high,aptitude%is%little),
  fuzzy_rule(exp%is%little,aptitude%is%little),
  fuzzy_rule(exp%is%acceptable||edu%is%acceptable||car%is%ok,aptitude%is%ok),
  fuzzy_rule(exp%is%much&&edu%is%little&&car%is%ok,aptitude%is%ok),
  fuzzy_rule(exp%is%much&&car%is%ok,aptitude%is%ok)
)
model <- fuzzy_system(variables,rules)
print(model)
plot(model)


#example_1
ex_1 <- fuzzy_inference(model,list(exp=75,edu=0,car=70))
plot(ex_1)
#defuzzify
gset_defuzzify(ex_1,"centroid")

#example 2
ex_2 <- fuzzy_inference(model,list(exp=30,edu=0,car=70))
gset_defuzzify(ex_2,"centroid")

#reset

