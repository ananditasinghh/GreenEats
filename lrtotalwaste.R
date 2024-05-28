library(dplyr)
library(ggplot2)

data <- read.csv("cleaneddata.csv")

convert_to_numeric <- function(column) {
  as.numeric(gsub("[^0-9.-]", "", column))}

# Convert relevant columns to numeric, handling non-numeric entries
data <- data %>%
  mutate("Household estimate (kg/capita/year)" = as.numeric("Household estimate (kg/capita/year)"),
         "Retail estimate (kg/capita/year)" = as.numeric("Retail estimate (kg/capita/year)"),
         "Food service estimate (kg/capita/year)" = as.numeric("Food service estimate (kg/capita/year)"),
         "Household estimate (tonnes/year)" = as.numeric("Household estimate (tonnes/year)"),
         "Retail estimate (tonnes/year)" = as.numeric("Retail estimate (tonnes/year)"),
         "Food service estimate (tonnes/year)" = as.numeric("Food service estimate (tonnes/year)"))

# Check for NA values and handle them (e.g., replace with 0)
data[is.na(data)] <- 0

# Linear regression: Predict Total Waste based on Household and Retail Waste
model <- lm(`combined.figures..kg.capita.year.` ~ `Household.estimate..tonnes.year.` + `Retail.estimate..tonnes.year.`, data = data)

# Summary of the regression model
summary(model)

# Extract the fitted values from the linear regression model
fitted_values <- predict(model)

# Create a scatterplot of observed vs. fitted values
plot(data$`combined.figures..kg.capita.year.`, fitted_values, 
     xlab = "Observed Total Waste (kg/capita/year)",
     ylab = "Fitted Total Waste (kg/capita/year)",
     main = "Observed vs. Fitted Values")

# Add a diagonal line for reference
abline(0, 1, col = "red")


colnames(data)