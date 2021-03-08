library(shiny)
#Load library that contains data
library(gapminder)
#Load tidyverse to filter data:
library(tidyverse)


#Create a panel
dataPanel <- tabPanel("Data",
                      selectInput(
                        inputId = "selYear",
                        label = "Select the Year",
                        choices = gapminder %>% select(year) %>% unique %>% arrange
                      ),
                      tableOutput("data")
)

# Define UI for application that draws a histogram
ui <- navbarPage("shiny App",
                dataPanel
                )

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$data <- renderTable(gapminder %>% filter(year == input$selYear))
}

# Run the application 
shinyApp(ui = ui, server = server)


