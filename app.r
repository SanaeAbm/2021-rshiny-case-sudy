library(shiny)
#Load library that contains data
library(gapminder)
#Load tidyverse to filter data:
library(tidyverse)

library(magrittr)



#Add static variable:
#Create the factor year before filtering:
gapminder %<>% mutate_at(c("year", "country"), as.factor)
gapminder_years = levels(gapminder$year) %>% str_sort()
gapminder_countries = levels(gapminder$country)
#Create a panel
dataPanel <- tabPanel("Data",
                      tableOutput("data")
)

#Create plot panel:
plotPanel <- tabPanel("Plot",
                      plotOutput("plot")
)

plotPanel <- tabPanel("Plot",
                      #Divide boostrap (12) en 8 for the plot 
                      fluidRow(
                        column(width = 8,
                               plotOutput("plot",
                                          hover = hoverOpts(id = "plot_hover", delayType = "throttle"),
                               )),
                        # and 4 columns for info
                        column(width = 4,
                               verbatimTextOutput("plot_hoverinfo")
                        )
                      )
)

myHeader <- div(
  selectInput(
    inputId = "selYear",
    label = "Select the Year",
    multiple = TRUE,
    choices = gapminder_years,
    selected = c(gapminder_years[1])
  ),
  selectInput(
    inputId = "selCountry",
    label = "Select the Country",
    multiple = TRUE,
    choices = gapminder_countries,
    selected = c(gapminder_countries[1])
  )
)




# Define UI for application that draws a histogram
ui <- navbarPage("shiny App",
                dataPanel,
                #add plot panel:
                plotPanel,
                #add header:
                header=myHeader
                
                )

# Define server logic required to draw a histogram
server <- function(input, output) {
  #Create a reactive function
  gapminder_year <- reactive({gapminder %>% filter(year %in% input$selYear, country %in% input$selCountry)})
  output$data <- renderTable(gapminder_year());
  output$plot <- renderPlot(
    #First 10 data; filter by year; taking variable population
    ggplot(data=head(gapminder_year()), aes(x=country, y=pop, fill=year))
    + geom_bar(stat="identity", position=position_dodge())
    )
}


# Run the application 
shinyApp(ui = ui, server = server)


