
library(shiny)
library(markdown)
library(ggplot2)
library(shinythemes)

intro_tab <- tabPanel(
  "Introduction",
  includeMarkdown("intro_paragraphs.md"),
  h2("Dynamic Paragraph"),
  p("First, I wanted to figure out which country had produced the largest CO2 emissions (measured in million tonnes)
      in any given year, and", max_co2_emissions, " was the country that had the highest ratio. After that, I started
      to explore variables that were related to GDP as well, and I discovered that", max_co2_gdp, "was the country
      that had the most inefficient GDP to CO2 emission ratio. In comparison, the world average
      CO2 to GDP ratio is only", round(world_average_co2gdp, 2), "million tonnes per 2011-international-dollar.
      I also wanted to compare these values to the four countries I am analyzing in my graph, so 
      the average GDP to CO2 emissions ratio for Canada was", round(ca_co2_gdp, 2), " million tonnes per 
      international dollar. For Japan, it was", round(jp_co2_gdp, 2), " million tonnes per international-dollar, 
      and for Taiwan and the United Kingdom, it was", round(tw_co2_gdp, 2), "million tonnes per international 
      dollar, and", round(uk_co2_gdp, 2), "million tonnes per international dollar. respectively. 
      Next, I looked at the world average energy to GDP ratio, which turned out to be",
      round(world_average_energy_gdp, 2), "kilowatts-hours per international-dollar. I also 
      wanted to know the average energy to GDP ratio of Taiwan and United Kingdom, which is", 
      round(tw_energy_gdp, 2), "and", round(uk_energy_gdp, 2), "kilowatt-hours per international-dollar.")
)
# reference: https://stackoverflow.com/questions/26636335/formatting-number-output-of-sliderinput-in-shiny
# This tab contains the interactive data visualization.
graph_tab <- tabPanel(
  "Interactive Graph", 
  sidebarLayout(
    sidebarPanel(
      # This widget lets the user pick which countries to filter through.
      checkboxGroupInput(inputId = "countries", 
                         label = "Country Selection", 
                         choiceNames = c("Canada", "Japan", "Taiwan", "United Kingdom"),
                         choiceValues = unique(graph_data$country),
                         selected = "Taiwan"),
      # This widget lets the user specify a desired year range.
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
      # This is my graph caption
      p("This graph shows the CO2 emissions per gross domestic product (measured in million tonnes
        per 2011-international-dollar) for four countries: Canada, Taiwan, Japan, and the United Kingdom. (NA
        values from the dataset were removed.) From this interactive graph, we can see that the highest 
        ratio of CO2 emissions to GDP is in Canada in 1921, with 1.666 million tonnes of CO2 emissions 
        per 2011-international-dollar while the lowest CO2 emissions to GDP 
        ratio is in Taiwan, in the year 1901 (and 1903), with 0.057 million tonnes of CO2 emission per 
        2011-international-dollar. We also see an upward and then downward trend for each 
        of the four countries, which implies that perhaps the four countries learned to optimize 
        their CO2 emissions without compromising their GDP as time progresses.")
    )
  )
)

ui <- navbarPage(
  theme = shinytheme("slate"),
  "Climate Change",
  intro_tab,
  graph_tab
)
