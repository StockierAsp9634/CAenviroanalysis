library(readxl)
library(dplyr)  
library(tidyverse)
library(lubridate)
library(ggplot2)

emData <- read.csv("C:\\Users\\arnav\\Documents\\CAenviroanalysis\\data\\nc-ghg_inventory_sector_all_00-22(Included emissions).csv")

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

ggplot(emData, )
