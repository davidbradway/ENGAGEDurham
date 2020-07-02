#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# Learn about shinyapps.io

library(readxl)
library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("ENGAGEDurham Input from Listening and Learning Engagement"),

    fluidRow(
        column(12,
               dataTableOutput(outputId = 'dataTable')
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    readfile <- 'Input from Listening and Learning Engagement.xlsx'
    data1 <- read_excel(readfile,1)
    data1$Group = 'Workshops'
    data2 <- read_excel(readfile,2)
    data2$Group = 'Online Survey'
    data3 <- read_excel(readfile,3)
    data3$Group = 'Engagement Ambassadors'
    data <- full_join(data1, data2)
    data <- full_join(data, data3)
    
    output$dataTable <- renderDataTable(data)
}

# Run the application 
shinyApp(ui = ui, server = server)
