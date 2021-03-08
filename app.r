library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(title="Shiny App",
                h1("hello"))

# Define server logic required to draw a histogram
server <- function(input, output) { }

# Run the application 
shinyApp(ui = ui, server = server)


