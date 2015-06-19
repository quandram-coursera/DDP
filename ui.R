library(shiny)
library(DT)
shinyUI(pageWithSidebar(
  headerPanel("Let this app steer you to your next car"),
  sidebarPanel(
    selectInput("oVariable", 
                "Please select the features that matter most to you in your prospective purchase", 
                choices = colnames(mtcars), multiple=TRUE)
    
  ),
  mainPanel(
        verbatimTextOutput("oText"),
        DT::dataTableOutput('oTable')
  )
))


# pick variable then operator and value
# enable go button only at this point
# make table display only on go button
# output notes on the data

