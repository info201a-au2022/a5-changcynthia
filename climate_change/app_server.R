library(tidyverse)
library(dplyr)
library(plotly)
library(ggplot2)

#checkboxGroupInput()

co2_data <- read.csv("./owid-co2-data.csv")
working_data <- co2_data %>%
  filter(country == "Taiwan" | country == "Canada" |
         country == "United Kingdom" | country == "Japan") %>%
  filter(year >= 1900)

# three relevant calculations 

max_co2_emissions <- co2_data %>%
  filter(co2 == max(co2, na.rm = TRUE)) %>%
  pull(country)

max_co2_gdp <- co2_data %>%
  filter(co2_per_gdp == max(co2_per_gdp, na.rm = TRUE)) %>%
  pull(country)

world_average_co2gdp <- co2_data %>%
  summarize(co2_per_gdp = mean(co2_per_gdp, na.rm = TRUE)) %>%
  pull(co2_per_gdp)

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

world_average_energy_gdp <- co2_data %>%
  summarize(energy_per_gdp = mean(energy_per_gdp, na.rm = TRUE)) %>%
  pull(energy_per_gdp)

tw_energy_gdp <- co2_data %>%
  filter(country == "Taiwan") %>%
  summarize(energy_per_gdp = mean(energy_per_gdp, na.rm = TRUE)) %>%
  pull(energy_per_gdp)

uk_energy_gdp <- co2_data %>%
  filter(country == "United Kingdom") %>%
  summarize(energy_per_gdp = mean(energy_per_gdp, na.rm = TRUE)) %>%
  pull(energy_per_gdp)