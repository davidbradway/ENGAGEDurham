
library(readxl)
library(dplyr)

readfile <- 'Input from Listening and Learning Engagement.xlsx'
data1 <- read_excel(readfile,1)
data1$Group = 'Workshops'
data2 <- read_excel(readfile,2)
data2$Group = 'Engagement Ambassadors'
data3 <- read_excel(readfile,3)
data3$Group = 'Online Survey'
data <- full_join(data1, data2)
data <- full_join(data, data3)
