#install.packages("openxlsx")
library(openxlsx)
install.packages("C5.0")
library(C5.0)
getwd()

creditData <- read.xlsx(xlsx ="credit_scoring.xlsx")
creditData$risk_rating <- as.factor(creditData$risk_rating)

creditData
str(creditData)

drop_columns <- c("kpr_aktifm ", "pendaptan_tahunan", "risk_rating", "rata_rata_overdue")

datafeed <- creditData[, !(names(creditData) %in% drop_columns)]

modelKu <- C5.0(datafeed, as.factor(creditData$risk_rating))
summery(modelKu)
