library(readxl)
library(dplyr)  
library(tidyverse)
library(lubridate)

file_path <- "C:/Users/arnav/OneDrive/Documents/CAenviroanalysis/data/ghg_inventory_by_ipcc_all_00-21.xlsx"
includedemissions <- read_excel(file_path, sheet = 2)

summary(includedemissions)

emissionslevelZero <- read_csv("C:/Users/arnav/Documents/CAenviroanalysis/data/levelZero.csv")

summary(emissionslevelZero)

