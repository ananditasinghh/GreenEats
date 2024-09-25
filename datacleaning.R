install.packages("tidyverse")
library(tidyverse)
install.packages("readr")
library(readr)
data <- read_csv("data.csv")
# Remove duplicates 
install.packages("dplyr")
library(dplyr)
data <- distinct(data)
# Handle missing values
install.packages("tidyr")
library(tidyr)
data <- data %>%
  drop_na()  # Remove rows with missing values
# Standardize text data
data <- data %>%
  mutate(across(where(is.character), toupper))
# Convert the "source" column to lowercase
library(dplyr)
data$Source <- tolower(data$Source)
str(data)
# Add serial number column
data <- data %>%
  mutate(Serial_Number = row_number())

# Write the cleaned dataset to a CSV file named "cleaneddata.csv"
write.csv(data, "cleaneddata.csv", row.names = FALSE)
clearPushBack()
