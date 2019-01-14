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
demo_info <- read_csv("../data/01_demo_info.csv")
mental_cond <- read_csv("../data/02_mh_condition.csv")
work_info <- read_csv("../data/03_workplace_info.csv")
mental_support <- read_csv("../data/04_org_support.csv")
Openness <- read_csv("../data/05_openness_about_mh.csv")

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
        
          # Droi
          selectInput("data_category", "Data Category: ", 
                      choices = c("Demographic information",
                                  "Mental health condition",
                                  "Workplace information",
                                  "Organizational mental health supports",
                                  "Openness about mental health")
                      ),
          
          br(),
          
          radioButtons("display_button", "Display style:",
                       list("Normal" = "rnorm",
                            "Uniform" = "runif",
                            "Right skewed" = "rlnorm",
                            "Left skewed" = "rbeta")),
          br(),
          
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
  data_filter <- reactive({
    
    if (input$data_category == "Mental health condition") {
      output_data <- mental_cond 
    } else if (input$data_category == "Workplace information") {
      output_data <- work_info
    } else if (input$data_category == "Organizational mental health supports"){
      output_data <- mental_support
    } else if (input$data_category == "Openness about mental health") {
      output_data <- Openness
    } else { # default 
      output_data <- demo_info
    }
    
    output_data <- output_data %>%
      rename(index = X1) %>% 
      mutate(index = as.integer(index))
      
  })
  
  # render the table
  output$data_table <- renderTable({
    data_filter()
  })
   
  
}





##################################################
## Section: run app
##################################################
# Run the application 
shinyApp(ui = ui, server = server)

