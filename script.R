library(readxl)
library(dplyr)  
library(tidyverse)
library(lubridate)
library(ggplot2)

file_path <- "C:/Users/arnav/Documents/CAenviroanalysis/data/ghg_inventory_by_ipcc_all_00-21.xlsx"
includedemissions <- read_excel(file_path, sheet = 2)

summary(includedemissions)

emissionslevelZero <- read_csv("C:/Users/arnav/Documents/CAenviroanalysis/data/levelZero.csv")

summary(emissionslevelZero)

emissionslevelZeroprelaw <- filter(emissionslevelZero, Year < 2013)

emissionslevelZeropostlaw <- filter(emissionslevelZero, Year >= 2013)


emissionslevelZero <- emissionslevelZero |> rename(totalIncludedEmissions = `Total Included Emissions`) 

ggplot(data = emissionslevelZero, aes(x = Year, y = `Total Included Emissions`)) + geom_line() 




