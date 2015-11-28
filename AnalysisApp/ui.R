library(shiny)

library(ggplot2)  # for the diamonds dataset

shinyUI(pageWithSidebar(
  headerPanel('Data Analysis and Visualization'),
  sidebarPanel(
    sliderInput("ageRange", "Age Range:",
                min = 15, max = 25, step =1, value = c(17,22))
  ),
  mainPanel(
    tabsetPanel(
      tabPanel('Data ETL',
               dataTableOutput("mergedTable")),
      tabPanel('Age Analysis',
               plotOutput("agePlot")),
      tabPanel('Spatial Analysis',
               plotOutput("usaMapPlot")),
      tabPanel('Princeton',
               plotOutput("princetonMapPlot")),
      tabPanel('NJ',
               plotOutput("cityPlot"))
      
    )
  )
))