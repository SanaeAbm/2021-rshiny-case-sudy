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

#Create plot panel:
plotPanel <- tabPanel("Plot",
                      plotOutput("plot")
)

plotPanel <- tabPanel("Plot",
                      plotOutput("plot")
)

# Define UI for application that draws a histogram
ui <- navbarPage("shiny App",
                dataPanel,
                #add plot panel:
                plotPanel
                )

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$data <- renderTable(gapminder %>% filter(year %in% input$selYear))
  output$plot <- renderPlot(
    #First 10 data; filter by year; taking variable population
    barplot(head(gapminder %>% filter(year %in% input$selYear) %>% pull(pop)),
            main=paste("Population in",input$selYear), horiz=FALSE,
            names.arg= head(gapminder %>% filter(year %in% input$selYear) %>% pull(country))
    )
  )
}

# Run the application 
shinyApp(ui = ui, server = server)


