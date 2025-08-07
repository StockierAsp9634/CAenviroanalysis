library(readxl)
library(dplyr)  
library(tidyverse)
library(lubridate)
library(ggplot2)
library(ggthemes)

emData <- read.csv("C:\\Users\\arnav\\Documents\\CAenviroanalysis\\data\\nc-ghg_inventory_sector_all_00-22(Included emissions).csv")

emissions_longer <- read.csv("C:\\Users\\arnav\\Documents\\CAenviroanalysis\\data\\nc-ghg_inventory_sector_all_00-22(Included emissions).csv")

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

emissions_longer$`Sector Level 1` <- as.factor(emissions_longer$`Sector Level 1`)
emissions_longer <- emissions_longer %>% 
  group_by(`Sector Level 1`) %>% 
  summarise(across(3:25, sum))

sector <- c(colnames(emData))
emData <- cbind(sector, emData)


colnames(emData) <- c("Year", "Agriculture", "Commercial", "Electricity Generation(Imports)", "Electricity Generation(In State)", "Industrial", "Residential", "Transportation")

ggplot(emData, )

ncol(emData)

colnames(emData)

rownames(emData)

emData$Year <- rownames(emData)

emData <- emData[, c("Year", setdiff(names(emData), "Year"))]

emData$Year <- as.numeric(emData$Year)

long_data <- pivot_longer(emData,
                          cols = Year, 
                          names_to = "Sector", 
                          values_to = "Emissions")
long_data$Year <- long_data$Emissions

long_data <- long_data %>% 
  select(-Emissions)

long_data <- long_data[, c("Year", setdiff(names(long_data), "Year"))]

ggplot(long_data, aes(x = Year, y = Emissions)) +
  geom_line(color = "steelblue", size = 1) +
  geom_point(color = "steelblue", size = 2) +
  facet_wrap(~ Sector, scales = "free_y") +
  labs(title = "Emissions by Sector Over Time",
       x = "Year",
       y = "Emissions") +
  theme_minimal()

head(long_data)

str(long_data)

long_data$Year <- as.numeric(long_data$Year)


long_data <- long_data %>%
  pivot_longer(
    cols = -Year,
    names_to = "Sector",
    values_to = "Emissions"
  )

ggplot(long_data, aes(x = Year, y = Emissions, color = Sector)) +
  geom_line(show.legend = FALSE) +
  facet_wrap(~ Sector, scales = "free_y") +
  labs(title = "Californian Emissions by Sector Over Time",
       x = "Year",
       y = "Emissions(Millions of Metric Tons)") + theme(plot.title = element_text(size = 13, hjust=0.5), axis.text.x = element_text(size = 6), strip.text = element_text(size = 8))
+ theme_economist()

str(long_data$Year)

long_data$Emissions <- as.numeric(long_data$Emissions)

long_data <- long_data %>% 
  rename( 
    "importElectricity" = "Electricity Generation(Imports)"
    )
long_data$Sector <- gsub("Electricity Generation \\(Imports\\)"
, "importElectricity", long_data$Sector)
long_data$Sector <- gsub("Electricity Generation \\(In State\\)", "nativeElectricity", long_data$Sector)

unique(long_data$Sector)
