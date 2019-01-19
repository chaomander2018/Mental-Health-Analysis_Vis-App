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
suppressPackageStartupMessages(library(gridExtra))
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
                                tabPanel("Graphs", verbatimTextOutput("Graphs"), 
                                         plotOutput("bar", height = "250px"), plotOutput("pie",height = "250px"))
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
  
  output$pie <- renderPlot({
    grid.arrange(leave_pie, 
                 awareness_pie,
                 ncol=2, nrow=1, 
                 widths=c(8,8))
  })  
  output$bar <- renderPlot({
    grid.arrange(interfere_bar, 
                 help_anony_bar,
                 ncol=2, nrow = 1,
                 widths = c(8,8))
    
    
    
  }) 
  
}

interfere_bar <-
  mental_cond %>% 
  ggplot(aes(x= factor(work_interfere),  fill = treatment ))+
  geom_bar(width = 0.5,position="dodge")+
  ggtitle("Work Interfer by Mental Health Condition")+
  xlab("Work Interfere")+
  guides(fill=guide_legend(title="Treatment"),
         axis.title.y = element_blank(),
         panel.grid.minor=element_blank(),
         plot.title = element_text(size=4))

h_help <- c("Yes","No") 
help_anony_bar <- mental_support %>% 
  filter(seek_help %in% h_help) %>% 
  ggplot(aes(x = seek_help))+
  geom_bar(width = 0.8, aes(fill = anonymity))+
  guides(fill=guide_legend(title="Anonymity"),
         panel.grid.minor=element_blank(),
         plot.title = element_text(size=4))+
  ggtitle("Anonymity and Seeking Help")

awareness_bar <- ggplot(mental_support, aes(x = factor(1), fill = care_options))+
  geom_bar(width = 1)+
  theme(axis.ticks=element_blank(),
        axis.text.y=element_blank(),
        axis.text.x=element_text(colour='black'))+
  ggtitle("Awareness of the Care Program")
awareness_bar

awareness_pie <- awareness_bar + coord_polar(theta = "y")+
  theme(axis.text.x=element_blank(),
        legend.title = element_text(colour="blue", size=0.1, face="bold")) 

leave_bar <- ggplot(mental_support, aes(x = factor(1), fill = leave))+
  geom_bar(width = 1)+
  theme(axis.ticks=element_blank(),
        axis.text.y=element_blank(),
        axis.text.x=element_text(colour='black'),
        legend.title = element_text(colour="blue", size=0.1, face="bold"))
leave_pie <- leave_bar+ coord_polar(theta = "y")+
  ggtitle("Easiness on Leaves")+
  theme(axis.text.x=element_blank())

##################################################
## Section: run app
##################################################
# Run the application 
shinyApp(ui = ui, server = server)

