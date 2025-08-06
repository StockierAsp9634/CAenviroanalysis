library(readxl)
library(dplyr)  
library(tidyverse)
library(lubridate)
library(ggplot2)

file_path <- "C:/Users/arnav/Documents/CAenviroanalysis/data/ghg_inventory_by_ipcc_all_00-21.xlsx"
includedemissions <- read_excel(file_path, sheet = 2)

summary(includedemissions)

emissionslevelZero <- read_csv("C:/Users/arnav/Documents/CAenviroanalysis/data/levelZero.csv")

emissionslevelZero <- emissionslevelZero |> rename(totalIncludedEmissions = `Total Included Emissions`) 


summary(emissionslevelZero)

emissionslevelZeroprelaw <- filter(emissionslevelZero, Year < 2013)

emissionslevelZeropostlaw <- filter(emissionslevelZero, Year >= 2013)



ggplot(data = emissionslevelZero, aes(x = Year, y = totalIncludedEmissions)) + geom_line() + ylab("Total Included Emissions") + labs(title = "California GHG emissions over the years")


ggplot(data = emissionslevelZeroprelaw, aes(x = Year, y = `Total Included Emissions`)) + geom_line()

ggplot(data = emissionslevelZeropostlaw, aes(x = Year, y = `Total Included Emissions`)) + geom_line()

#importing data set
emData <- read.csv("C:\\Users\\Arav Kanyal\\Documents\\CAenviroanalysis\\data\\nc-ghg_inventory_sector_all_00-22(Included emissions).csv")

#wrangling
colnames(emData) <- emData[1, ]
emData <- emData[-1, ]
emData <- emData [, -c(1:2, 4:8, 34)]
emData <- na.omit(emData)
emData$`Sector Level 1` <- as.factor(emData$`Sector Level 1`)
emData <- emData %>%
  group_by(`Sector Level 1`) %>%
  summarise(across(3:25, sum))
emData <- t(emData)
emData <- as.data.frame(emData)
colnames(emData) <- emData[1, ]
emData <- emData[-1, ]

#Emissions by Sector (2000-22)
plot.ts(emData)