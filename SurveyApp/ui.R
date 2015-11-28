library(shiny)

# Define UI for application that draws a histogram
shinyUI(pageWithSidebar(
  headerPanel("Survey App"),
  sidebarPanel(
      numericInput("age", label = "How old are you?", min = 17, max = 22, value = NULL),
      textInput("zipcode", label = "Zip Code", value = ""),
      selectInput("anxiety", label = "Do you have anxiety?",choices = list("YES" = 1, "NO" = 0, " " = 2), selected = 2),
      actionButton("btnSubmit", label = "Submit"),
      h6("Click 'Submit' to save a survey record and/or reload the result table.")
    ),
    mainPanel(
      #verbatimTextOutput("nText"),
      dataTableOutput("mytable1")
  )
    
))