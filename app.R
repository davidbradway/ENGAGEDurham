#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# Learn about shinyapps.io
#
# Reference for Tutorial, ShinyWidgets: https://www.davidsolito.com/post/conditional-drop-down-in-shiny/

library(readxl)
library(dplyr)
library(shiny)
library(shinyWidgets)

ui <- fluidPage(
    titlePanel("EngageDurham Input from Listening and Learning Sessions"),
    hr(),
    fluidRow(
        column(12,
               selectizeGroupUI(
                   id = "my-filters",
                   inline = TRUE,
                   btn_label = "Reset Filters",
                   params = list(
                       var_one = list(inputId = "Topic_1", 
                                      title = "Select Topic 1s", 
                                      placeholder = 'select'),
                       var_two = list(inputId = "Topic_2", 
                                      title = "Select Topic 2s", 
                                      placeholder = 'select'),
                       var_three = list(inputId = "Group", 
                                        title = "Select Group", 
                                        placeholder = 'select')
                   )
               )
        )
    ),
    tableOutput("table")
)

server = function(input, output, session) {

    readfile <- 'Input from Listening and Learning Engagement.xlsx'
    data1 <- read_excel(readfile,1)
    data1$Group = 'Workshops'
    data2 <- read_excel(readfile,2)
    data2$Group = 'Engagement Ambassadors'
    data3 <- read_excel(readfile,3)
    data3$Group = 'Online Survey'
    data <- full_join(data1, data2)
    data <- full_join(data, data3)
    
    res_mod <- callModule(
        module = selectizeGroupServer,
        id = "my-filters",
        data = data,
        vars = colnames(data)
    )

    output$table <- renderTable({
        res_mod()
    })
}
    
options = list(height = 500)

# Run the application 
shinyApp(ui = ui, server = server, options = options)
