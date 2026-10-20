## ELECTRE - Evaluate alternatives with criteria
library(readxl)
library(MCDA)
# data files live in data/ (run from the repository root)
data<-read_excel("data/electre_datos_seg3.xlsx")
print(data)
w<-as.vector(t(data[-1,6]))
names(w)<- t(data[2:5,1]) 
str(w)

#defining the preference thresholds, p 

p<- as.vector(rep(1,4))# may be better to use 1 as a value 
names(p) <- t(data[2:5,1])
p

#defining the indifference thresholds, q 
q<- as.vector(rep(0.5,4))
names(q)<-t(data[2:5,1])
q

#veto, threshold,v
v<-as.vector(rep(5,4))
names(v)<-t(data[2:5,1])
v


#defining scores matrix with the evaluations from experts
scores<- data.frame(t(data[-1,2:4]))
rownames(scores)<- data[1,2:4]
colnames(scores)<- t(data[2:5,1])
scores
scores1<-data.frame(lapply(scores,as.numeric))
scores1<-as.matrix(scores1)
result<-ELECTRE3(scores1,q,p,v,w)
result$scoring
