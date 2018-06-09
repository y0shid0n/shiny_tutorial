library(shiny)

# サーバロジックの定義
shinyServer(function(input, output) {
  output$text1 <- renderText({
    paste("you have selected", input$var, sep = ": ")
  })
  
  output$text2 <- renderText({
    paste("You have chosen a range that goes from ", input$range[1], "to", input$range[2])
  })
  
  })