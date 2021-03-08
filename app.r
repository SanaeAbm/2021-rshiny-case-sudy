library(shiny)
#Load library that contains data
library(gapminder)
#Load tidyverse to filter data:
library(tidyverse)

#Add static variable:
gapminder_years = gapminder %>% select(year) %>% unique %>% arrange

#Create a panel
dataPanel <- tabPanel("Data",
                      selectInput(
                        inputId = "selYear",
                        label = "Select the Year",
                        #To choose more than 1 year
                        multiple = TRUE,
                        choices = gapminder_years,
                        #introduce a default selection: the first year
                        #NEVER EMPTY APPS
                        selected =gapminder_years
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
  #Create a reactive function
  gapminder_year <- reactive({gapminder %>% filter(year %in% input$selYear)})
  output$data <- renderTable(gapminder_year());
  output$plot <- renderPlot(
    #First 10 data; filter by year; taking variable population
    barplot(head(gapminder_year()%>% pull(pop)),
            main=paste("Population in",input$selYear), horiz=FALSE,
            names.arg= head(gapminder_year() %>% pull(country))
    )
  )
}


# Run the application 
shinyApp(ui = ui, server = server)


