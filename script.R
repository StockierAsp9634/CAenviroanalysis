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


