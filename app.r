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
                        #To choose more than 1 year
                        multiple = TRUE,
                        choices = gapminder %>% select(year) %>% unique %>% arrange, 
                        #introduce a default selection: the first year
                        #NEVER EMPTY APPS
                        selected =gapminder%>% select(year)%>% head(1)
                      ),
                      tableOutput("data")
)

# Define UI for application that draws a histogram
ui <- navbarPage("shiny App",
                dataPanel
                )

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$data <- renderTable(gapminder %>% filter(year %in% input$selYear))
}

# Run the application 
shinyApp(ui = ui, server = server)


