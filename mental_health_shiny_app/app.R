#! /usr/bin/env Rscript

##################################################
## Project: 
## Date: 
## Author: Mengda (Albert) Yu [aut cre]
## Script purpose: 
##  
#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
##################################################


suppressPackageStartupMessages(library(shiny))
suppressPackageStartupMessages(library(tidyverse))


# Prepare data
demo_info <- read_csv("../data/survey.csv")
# mental_cond <- read_csv()
# work_info <- read_csv()
# mental_support <- read_csv()
# Openness <- read_csv()

##################################################
## Section: UI layout
##################################################
# Define UI for application that draws a histogram
ui <- fluidPage(

   # Application title
   titlePanel("2014 Tech Mental Health Survey", 
              windowTitle = "Shiny app"),
   
   
 
   
   # Sidebar 
   sidebarLayout(
     
     
      
     # =========================================
     # The side bar 
     
      sidebarPanel(
        
          selectInput("data_category", "Data Category: ", 
                      choices = c),
          
          br()
          
         
      ),
      
      
      
      
      # =========================================
      # The main Panel
      mainPanel(
        
          tableOutput("data_table")
          
      )
   )

   
)




##################################################
## Section: Server layout
##################################################
# Define server logic required to draw a histogram
server <- function(input, output) {
  
  # Data category filter
  
  data_filter <- reactive(
    bcl %>%
      filter(Price > input$priceInput[1],
             Price < input$priceInput[2]) 
  )
  
  output$data_table <- renderTable({
    demo_info
  })
   
  
}





##################################################
## Section: run app
##################################################
# Run the application 
shinyApp(ui = ui, server = server)

