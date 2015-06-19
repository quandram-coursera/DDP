library(shiny)
shinyServer(
  function(input, output) {
      
    thisVariable <- reactive({ 
        thisVariable <- input$oVariable
    })
      
    output$oTable <- renderDataTable({
        tV <- thisVariable()
        if (is.null(tV)){
            thisOutput <- mtcars
        } else {
            tempList <- list()
            mainList <- list()
            for (i in 1:length(tV)){
                tempList <- which(mtcars[,as.character(tV[i])] > mean(mtcars[,as.character(tV[i])]))
                if (length(mainList)==0){
                    mainList <- tempList
                }
                mainList <- Reduce(intersect, list(mainList, tempList))
            } 
            thisOutput <- mtcars[unlist(mainList),]
        }
        thisOutput
        }, options = list(
                lengthMenu = list(c(10, 20, -1), c('10', '20', 'All')),
                pageLength = 10,
                searching = FALSE
            )
    )
    
    output$oText <- renderText({
            tV <- thisVariable()
            if (is.null(tV)){
                thisOutput <- "" 
            } else if (length(tV) == 1) {
                thisOutput <- paste("You have selected the variable ", tV[1],
                                    ".  The following cars are well suited to your needs.")
            } else {
                thisOutput <- paste("You have selected the variables ", 
                                    paste(tV[1:length(tV)-1], collapse = ', '), 
                                    " & ", tV[length(tV)], 
                                    ".  The following cars are well suited to your needs.")
            }
            thisOutput
    })
    
  }
)
