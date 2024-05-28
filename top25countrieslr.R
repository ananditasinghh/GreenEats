library(dplyr)
library(ggplot2)

# Calculate the total waste for each country
total_waste <- data %>%
  group_by(Country) %>%
  summarise(Total_Waste = sum(`combined.figures..kg.capita.year.`, na.rm = TRUE)) %>%
  arrange(desc(Total_Waste)) %>%
  top_n(25) # Select top 25 waste-producing countries

# Filter data for the top 25 waste-producing countries
top_25_countries <- data %>%
  filter(Country %in% total_waste$Country)

# Fit linear regression model for the top 25 countries
model <- lm(`combined.figures..kg.capita.year.` ~ `Household.estimate..tonnes.year.` + `Retail.estimate..tonnes.year.`,
            data = top_25_countries)

# Calculate fitted values
fitted_values <- predict(model)

# Create a dataframe with observed and fitted values
plot_data <- data.frame(
  Observed = top_25_countries$`combined.figures..kg.capita.year.`,
  Fitted = fitted_values
)

# Create a scatterplot
ggplot(plot_data, aes(x = Observed, y = Fitted)) +
  geom_point() +
  geom_abline(intercept = 0, slope = 1, color = "red") +
  labs(x = "Observed Total Waste (kg/capita/year)",
       y = "Fitted Total Waste (kg/capita/year)",
       title = "Observed vs. Fitted Values for Top 25 Waste-Producing Countries") +
  theme_minimal()
