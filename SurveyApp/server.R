library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  source("dataHelpers.R")
 
  data <- eventReactive(input$btnSubmit, {
    Save2SurveyCSV (input$age,input$zipcode,input$anxiety)
    GetSurveyCSV()
  })
  
 
  output$mytable1 <- renderDataTable({
     data()
  }, options = list(lengthMenu = c(10, 30, 50), pageLength = 10))
 
  #output$nText <- renderText(ntext())
})