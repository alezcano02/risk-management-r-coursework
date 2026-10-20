#MCDA
if (!require('MCDA')) install.packages('MCDA');library(MCDA)
if (!require('tibble')) install.packages('tibble');library(tibble)
library(readxl)
# data files live in data/ (run from the repository root)


# Evaluation of the criteria with matrices, this is also done in excel
criteria<- read_excel('data/AHP TomDickHarry_cl.xlsx',col_names=FALSE,range='C3:D6')

#eliminate the ´ 
criteria[2,2] <- 'Educacion'
criteria

alternatives <- read_excel('data/AHP TomDickHarry_cl.xlsx',col_names=FALSE,range='C29:D31')
alternatives

criteria_calif <- read_excel('data/AHP TomDickHarry_cl.xlsx',col_names=TRUE,range='C9:G13')
criteria_calif

criteria_calif[is.na(criteria_calif)] <- 1.0
criteria_calif


criteria_comp <- criteria_calif[,2:5]
#new
criteria_comp <- as.matrix(criteria_comp)
#str(criteria_comp)

rownames(criteria_comp) <- t(colnames(criteria_comp))
criteria_comp

exp <- read_excel('data/AHP TomDickHarry_cl.xlsx',col_names=TRUE,range='C33:F36')
exp[is.na(exp)] <- 1.0
exp <- column_to_rownames(exp,var="CR 1")
exp

edu <- read_excel('data/AHP TomDickHarry_cl.xlsx',col_names=TRUE,range='C40:F43')
edu[is.na(edu)] <- 1.0
edu <- column_to_rownames(edu,var="CR2")
edu

carisma <- read_excel('data/AHP TomDickHarry_cl.xlsx',col_names=TRUE,range='C46:F49')
carisma[is.na(carisma)] <- 1.0
carisma <- column_to_rownames(carisma,var="CR3")
carisma

age <- read_excel('data/AHP TomDickHarry_cl.xlsx',col_names=TRUE,range='C52:F55')
age[is.na(age)] <- 1.0
age <- column_to_rownames(age,var="CR4")
age


# until here everything was to set up the excel, the model is below
alt_comp <- list(Experiencia=exp,Educacion=edu,Carisma=carisma,Edad=age)
AHP(criteria_comp,alt_comp)
