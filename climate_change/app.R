#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(markdown)
library(ggplot2)

values <- source("./app_server.R")

intro_tab <- tabPanel(
    "Introduction",
    includeMarkdown("intro_paragraphs.md"), 
    p("hi yes")
)
# reference: https://stackoverflow.com/questions/26636335/formatting-number-output-of-sliderinput-in-shiny
graph_tab <- tabPanel(
    "Interactive Graph", 
    sidebarLayout(
        sidebarPanel(
            #checkboxGroupInput(inputId = input$countries, 
                               #label = "Country Selection", 
                              # choices = "Taiwan", "Japan", "United Kingdom", "Canada",
                               #selected = FALSE),
            sliderInput("bins", "Year", 1900, 2021, value = c(1900, 2014), sep = "")
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot")
        )
    )
)

    # Sidebar with a slider input for number of bins 
   
ui <- navbarPage(
    "Climate Change",
    intro_tab,
    graph_tab
)

server <- function(input, output) {
    
   # output$txt <- renderText({
   #     countries <- paste(input$countries, collapse = ", ")
   ##     paste("You chose", icons)
    #})
    
    output$linePlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)
        
        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
