
library(shiny)
library(markdown)
library(ggplot2)
library(shinythemes)

intro_tab <- tabPanel(
  "Introduction",
  includeMarkdown("intro_paragraphs.md"),
  h3("Dynamic Paragraph"),
  p("First, I wanted to figure out which country had produced the largest CO2 emissions
      in any given year, and it turned out to be", max_co2_emissions, ". After that, I started
      to explore variables that were related to GDP as well, so", max_co2_gdp, "was the country
      that had the most inefficient GDP to CO2 emission ratio. In comparison, the world average
      GDP to CO2 ratio is only", round(world_average_co2gdp, 2), ". I also wanted to compare these values to
      the four countries I am analyzing in my graph, so the average GDP to CO2 emissions ratio for 
      Canada was", round(ca_co2_gdp, 2), ". For Japan, it was", round(jp_co2_gdp, 2), ", and for Taiwan 
      and the United Kingdom, it was", round(tw_co2_gdp, 2), "and", round(uk_co2_gdp, 2),
      ", respectively. Next, I looked at the world average energy to GDP ratio, which turned out to be",
      round(world_average_energy_gdp, 2), "kilowatts per unit dollar ?? wtf I also wanted to know the average
      energy to gdp ratio of Taiwan and United Kingdom, which is", round(tw_energy_gdp, 2), "and", 
      round(uk_energy_gdp, 2), "kilowatts per unit dollar.")
)
# reference: https://stackoverflow.com/questions/26636335/formatting-number-output-of-sliderinput-in-shiny
graph_tab <- tabPanel(
  "Interactive Graph", 
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput(inputId = "countries", 
                         label = "Country Selection", 
                         choiceNames = c("Canada", "Japan", "Taiwan", "United Kingdom"),
                         choiceValues = unique(graph_data$country),
                         selected = "Taiwan"),
      sliderInput(inputId = "years", 
                  label = "Year",
                  min = min(graph_data$year),
                  max = max(graph_data$year),
                  value = c(1900, 2018),
                  sep = "")
    ),
    
    # Show a scatter plot
    mainPanel(
      plotlyOutput("scatter"),
      p("")
    )
  )
)

ui <- navbarPage(
  #theme = shinytheme("united"),
  "Climate Change",
  intro_tab,
  graph_tab
)