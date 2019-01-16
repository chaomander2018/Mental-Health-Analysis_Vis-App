#! /usr/bin/env Rscript

##################################################
## Project: 
## Date: 
## Author: Chao Wange [cre] and Mengda (Albert) Yu [aut cre]
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
#suppressPackageStartupMessages(library(DT))


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
ui <- navbarPage("C&A",
                 
                 # ============================================
                 # The main tab
                 # -  contains data and graph page
                 tabPanel("Main",
                          
                          # Sidebar 
                          sidebarLayout(
                
                            # The side bar panel
                            sidebarPanel(
                              
                              # Select data category
                              selectInput("data_category", "Data Category: ", 
                                          choices = c("Demographic information",
                                                      "Mental health condition",
                                                      "Workplace information",
                                                      "Organizational mental health supports",
                                                      "Openness about mental health")
                              ),
                        
                              br(),
                              
                              # Radio button to select the display style
                              radioButtons("display_button", "Display style:",
                                           list("Datatable",
                                                "Structure",
                                                "Summary"),
                                           selected = "Datatable"),
                              
                              br(),
                              
                              br(),
                              
                              
                              actionButton(inputId='ab1', 
                                           label="Help", 
                                           icon = icon("question", "fa-1x"),
                                           onclick ="window.open('http://google.com', '_blank')")
                              
                            ),
                            
                            
                          
                            # The main Panel
                            mainPanel(
                              
                              tabsetPanel(
                                tabPanel("Table", 
                                         tags$h2("Preview"),
                                         dataTableOutput("data_table"), 
                                         verbatimTextOutput("structure"),
                                         verbatimTextOutput("summary")),
                                tabPanel("Graphs", verbatimTextOutput("Graphs"))
                              )
                              
                            )
                          )
                          
                          
                 ),
                 
                 
                 # ============================================
                 # The about tab
                 # -  contains team info and the description of the project 
                 tabPanel("About",
                          
                          fluidRow(
                            
                            column(12,
                                includeMarkdown("../README.md")
                                )
                          )
                          
                          
                 )
                 
                 # ============================================
                 # The poweroff tab
                 # -  to close the app 
                 # tabPanel("", 
                 #          icon = icon("power-off"),
                 #          stopApp()
                 #            )
                 

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
  output$data_table <- renderDataTable({
    if (input$display_button == "Datatable") {
      # datatable(data_filter(), options = list(
      #   pageLength = 10,
      #   lengthMenu = c(5, 10, 15, 20)
      # ))
      data_filter()
    }
  }, options = list(pageLength = 10, dom = 'lftipr'))
  
  # render the summary 
  output$summary <- renderPrint({
    if (input$display_button == "Summary"){
      summary(data_filter())
    }
  })
  
  # render the structure
  output$structure <- renderPrint({
    if (input$display_button == "Structure"){
      str(data_filter())
    }
  })
  
  
}



##################################################
## Section: run app
##################################################
# Run the application 
shinyApp(ui = ui, server = server)

