library(tidyverse)
library(dplyr)
library(plotly)
library(ggplot2)


co2_data <- read.csv("./owid-co2-data.csv")

# This variable stores a filtered dataset from 1900 to 2018,
# with only four countries.
working_data <- co2_data %>%
  filter(country == "Taiwan" | country == "Canada" |
         country == "United Kingdom" | country == "Japan") %>%
  filter(year >= 1900 & year <= 2018)

graph_data <- working_data %>%
  select(country, year, co2_per_gdp) %>%
  mutate(co2_per_gdp = coalesce(co2_per_gdp, 0))

# three relevant calculations 

# This calculates the country with the largest CO2 emissions
max_co2_emissions <- co2_data %>%
  filter(co2 == max(co2, na.rm = TRUE)) %>%
  pull(country)

# This calculates the country with the largest CO2 emissions per GDP
max_co2_gdp <- co2_data %>%
  filter(co2_per_gdp == max(co2_per_gdp, na.rm = TRUE)) %>%
  pull(country)

# This calculates the world average CO2 emissions per GDP ratio
world_average_co2gdp <- co2_data %>%
  summarize(co2_per_gdp = mean(co2_per_gdp, na.rm = TRUE)) %>%
  pull(co2_per_gdp)

# The next four calculations are the average CO2 emissions per
# GDP ratio for the four countries I am focusing on in the data
# visualization portion: UK, Taiwan, Canada, and Japan.
uk_co2_gdp <- co2_data %>%
  filter(country == "United Kingdom") %>%
  summarize(co2_per_gdp = mean(co2_per_gdp, na.rm = TRUE)) %>%
  pull(co2_per_gdp)

tw_co2_gdp <- co2_data %>%
  filter(country == "Taiwan") %>%
  summarize(co2_per_gdp = mean(co2_per_gdp, na.rm = TRUE)) %>%
  pull(co2_per_gdp)

ca_co2_gdp <- co2_data %>%
  filter(country == "Canada") %>%
  summarize(co2_per_gdp = mean(co2_per_gdp, na.rm = TRUE)) %>%
  pull(co2_per_gdp)

jp_co2_gdp <- co2_data %>%
  filter(country == "Japan") %>%
  summarize(co2_per_gdp = mean(co2_per_gdp, na.rm = TRUE)) %>%
  pull(co2_per_gdp)


# This calculates the world average energy to GDP ratio
world_average_energy_gdp <- co2_data %>%
  summarize(energy_per_gdp = mean(energy_per_gdp, na.rm = TRUE)) %>%
  pull(energy_per_gdp)

# The following two variables calculate the average energy 
# to GDP ratio for Taiwan and the United Kingdom
tw_energy_gdp <- co2_data %>%
  filter(country == "Taiwan") %>%
  summarize(energy_per_gdp = mean(energy_per_gdp, na.rm = TRUE)) %>%
  pull(energy_per_gdp)

uk_energy_gdp <- co2_data %>%
  filter(country == "United Kingdom") %>%
  summarize(energy_per_gdp = mean(energy_per_gdp, na.rm = TRUE)) %>%
  pull(energy_per_gdp)


# server function that plots the interactive scatterplot
server <- function(input, output){
  output$scatter <- renderPlotly({
    ggplot() + geom_point(data = graph_data %>% filter(country %in% req(input$countries)),
                          aes(x = year, y = co2_per_gdp, color = country)) + 
      xlim(input$years[1], input$years[2]) 
  })
}

# https://community.rstudio.com/t/selecting-a-specific-scatterplot-point-in-shinyplot/69559/2
# Lilia helped me with the server function!

