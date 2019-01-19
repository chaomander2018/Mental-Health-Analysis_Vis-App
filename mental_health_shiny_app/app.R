#! /usr/bin/env Rscript

##################################################
## Project: 
## Date: 
## Author: Chao Wange [cre] and Mengda (Albert) Yu [aut cre]
## Script purpose: 
##  
##
##################################################


suppressPackageStartupMessages(library(shiny))
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(gridExtra))
suppressPackageStartupMessages(library(plotly))
#suppressPackageStartupMessages(library(DT))


# Prepare data
demo_info <- read_csv("../data/01_demo_info.csv")
mental_cond <- read_csv("../data/02_mh_condition.csv")
work_info <- read_csv("../data/03_workplace_info.csv")
mental_support <- read_csv("../data/04_org_support.csv")
Openness <- read_csv("../data/05_openness_about_mh.csv")
tidyall <- read_csv("../data/06_data_tidy.csv")

##################################################
## Section: UI layout
##################################################
# Define UI for application that draws a histogram
ui <- navbarPage("C&A",
                 
        # ============================================
        # The main tab
        # ============================================
        # -  contains data and graph page
        tabPanel("Main",
                 
                 # Sidebar 
                 sidebarLayout(
                   
                   # The side bar panel
                   sidebarPanel(width = 3,
                     
                     tags$h3("Efftiveness of Tech Company Mental Health Support"),
                     hr(),
                     selectInput("selectTopic", label = h4("Topic"), 
                                 choices = list("1. Does your employer provide mental health benefits?" = "benefits",
                                                "2. Do you know the options for mental health care your employer provides?" = "care_options",
                                                "3. Has your employer ever discussed mental health as part of an employee wellness program?" = "wellness_program",
                                                "4. How easy is it for you to take medical leave for a mental health condition?" = "leave"), 
                                 selected = "benefits"),
                     selectInput("selectCountry", label = h4("Country"), 
                                 choices = list("All" = "All",
                                                "US" = "United States", 
                                                "Other" = "Other"), 
                                 selected = "All"),
                     selectInput("selectVariable", label = h4("Variable"), 
                                 choices = list("Age" = "Age",
                                                "Gender" = "Gender",
                                                "Is remote work?" = "remote_work",
                                                "Is self-employed?" = "self_employed", 
                                                "Is a tech company?" = "tech_company"), 
                                 selected = "Age"),
                     hr(),
                     radioButtons("radioGraphType", label = h4("Graph type"),
                                  choices = list("Bar graph" = "bar", 
                                                 "Pie graph" = "pie"), 
                                  selected = "bar", inline = TRUE),
                     uiOutput("ui"),
                     br(),
                     # Help button 
                     actionLink(inputId='ab1', 
                                  label="Help", 
                                  icon = icon("question", "fa-1x"),
                                  onclick ="window.open('https://github.com/UBC-MDS/Mental-Health-Analysis_Vis-App', '_blank')")
                     
                   ),
                   
                   # The main Panel
                   mainPanel(
                     tabsetPanel(
                       tabPanel("Graphs", 
                                verbatimTextOutput("Graphs"), 
                                plotlyOutput("row_1_l")
                                # plotOutput("row_1_r")
                                # plotOutput("bar", height = "250px"), 
                                # plotOutput("pie")
                                ),
                       tabPanel("Table", 
                                tags$h1("Data Preview"),
                                fluidRow(
                                  column(12, wellPanel(
                                    # Select data category
                                    selectInput("data_category", "Data Category: ", 
                                                choices = c("Demographic information",
                                                            "Mental health condition",
                                                            "Workplace information",
                                                            "Organizational mental health supports",
                                                            "Openness about mental health")
                                    ),
                                    radioButtons("display_button", "Display style:",
                                                 list("Datatable","Structure","Summary"),
                                                 selected = "Datatable", inline = TRUE, width='100%')
                                    
                                    )
                                  )
                                ),
                                dataTableOutput("data_table"), 
                                verbatimTextOutput("structure"),
                                verbatimTextOutput("summary")
   
                       )
                     )
                   )
                 )
        ),
        
        
        # ============================================
        # The about tab
        # ============================================
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
        # ============================================
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
    
    # Generate output with index
    output_data <- output_data %>%
      rename(index = X1) %>% 
      mutate(index = as.integer(index))
  })
  
  # ==================================================
  # Data page
  # ==================================================
  
  # render the table
  output$data_table <- renderDataTable({
    if (input$display_button == "Datatable") {
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
  
  # ==================================================
  # Graph page
  # ==================================================
  graph_filter <- reactive ({
    
    # filter by country
    if (input$selectCountry == "United States"){
      output_graph_data <-  tidyall %>%
        filter(Country == "United States")
    } else if (input$selectCountry == "Other") {
      output_graph_data <-  tidyall %>%
        filter(Country != "United States")
    } else {
      output_graph_data <-  tidyall
    }
    
  })
  
  output$ui <- renderUI({
    if (is.null(input$radioGraphType))
      return()
    
    # Depending on input$input_type, we'll generate a different UI component and send it to the client.
    switch(input$radioGraphType,
           "bar" = radioButtons("radioBarPos", label = h5("Bar position"),
                                choices = list("Stack" = "stack", 
                                               "Dodge" = "dodge"), 
                                selected = "stack", inline = TRUE)
    )
  })
  
  constructe_plot <- reactive({
    if (is.null(input$radioBarPos))
      return()
    
    if (input$selectTopic == "care_options"){
      mytitle <- "Whether employees know the options\n for mental health care"
    } else if (input$selectTopic == "wellness_program") {
      mytitle <- "Whether employers discussed mental health \n as part of an employee wellness program"
    } else if (input$selectTopic == "leave") {
      mytitle <- "How easy to take medical leave \n for a mental health condition"
    } else {
      mytitle <- "Does your employer provide \n mental health benefits?"
    }
    
    if (input$radioGraphType == "pie"){
      
      pie_data <- graph_filter() %>%
        group_by(!!sym(input$selectTopic)) %>%
        summarise (n = n()) %>%
        mutate(new_labels = as.factor(!!sym(input$selectTopic)))
        
      p <- plot_ly(pie_data,  labels = ~new_labels, values = ~n, type = 'pie') %>%
        layout(title = mytitle,
               height = 670,
               font=list(family = "American Typewriter", size = 17, color = 'black'),
               xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
               yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
               margin = list(l = 100, r = 2, b = 2, t = 85, pad = 4))

    } else {
      
    p <- graph_filter() %>%
      ggplot(aes(x=!!sym(input$selectTopic), fill = !!sym(input$selectVariable))) +
      geom_bar(width = 0.8,  position = input$radioBarPos, colour="black", size=.1) +
      theme_classic() + 
      labs(x = input$selectTopic,
           y = "The count",
           title = mytitle) +
      theme(panel.grid.minor = element_blank(),
            plot.title = element_text(size = 19, hjust = 0.5,  family="American Typewriter", lineheight=1.2),
            plot.margin = margin(40, 2, 2, 2),
            axis.text.x = element_text(size = 12, face = "bold"),
            axis.text.y = element_text(size = 10),
            legend.title = element_blank(),
            legend.position = "top") +
      guides(fill=guide_legend(title=input$selectVariable))
    
    }
  })
  
  output$row_1_l <- renderPlotly({
    if (!is.null(input$radioBarPos)){
      p <- constructe_plot()
      ggplotly(p, height = 670)  %>% layout(legend =list(size = 20))
    }
  })
  
  # output$bar <- renderPlot({
  #   grid.arrange(interfere_bar, 
  #                help_anony_bar,
  #                ncol=2, nrow = 1,
  #                widths = c(8,8))
  # })
  # 
  # output$pie <- renderPlot({
  #   if (input$radioGraphType != "bar"){
  #   grid.arrange(constructe_plot() + coord_polar(theta = "y"),
  #                awareness_pie,
  #                ncol=2, nrow=1,
  #                widths=c(8,8))
  #   }
  # })
  
}

# interfere_bar <-
#   mental_cond %>% 
#   ggplot(aes(x= factor(work_interfere),  fill = treatment ))+
#   geom_bar(width = 0.5,position="dodge")+
#   ggtitle("Work Interfer by Mental Health Condition")+
#   xlab("Work Interfere")+
#   guides(fill=guide_legend(title="Treatment"),
#          axis.title.y = element_blank(),
#          panel.grid.minor=element_blank(),
#          plot.title = element_text(size=4))
# 
# h_help <- c("Yes","No") 
# 
# help_anony_bar <- mental_support %>% 
#   filter(seek_help %in% h_help) %>% 
#   ggplot(aes(x = seek_help))+
#   geom_bar(width = 0.8, aes(fill = anonymity))+
#   guides(fill=guide_legend(title="Anonymity"),
#          panel.grid.minor=element_blank(),
#          plot.title = element_text(size=4))+
#   ggtitle("Anonymity and Seeking Help")
# 
# awareness_bar <-
#   ggplot(mental_support, aes(x = factor(1), fill = care_options))+
#   geom_bar(width = 1)+
#   theme(axis.ticks=element_blank(),
#         axis.text.y=element_blank(),
#         axis.text.x=element_text(colour='black'))+
#   ggtitle("Awareness of the Care Program")
# 
# 
# awareness_pie <-
#   awareness_bar + coord_polar(theta = "y")+
#   theme(axis.text.x=element_blank(),
#         legend.title = element_text(colour="blue", size=0.1, face="bold"))
# 
# leave_bar <-
#   ggplot(mental_support, aes(x = factor(1), fill = leave))+
#   geom_bar(width = 1)+
#   theme(axis.ticks=element_blank(),
#         axis.text.y=element_blank(),
#         axis.text.x=element_text(colour='black'),
#         legend.title = element_text(colour="blue", size=0.1, face="bold"))
# 
# leave_pie <- leave_bar+ coord_polar(theta = "y")+
#   ggtitle("Easyness on Leaves")+
#   theme(axis.text.x=element_blank())

##################################################
## Section: run app
##################################################
# Run the application 
shinyApp(ui = ui, server = server)

