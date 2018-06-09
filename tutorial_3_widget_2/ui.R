library(shiny)

# アプリケーションの UI 定義。ヒストグラムを描く
shinyUI(fluidPage(
  titlePanel(
    strong("censusVis")
    ),
  
  sidebarLayout(
    sidebarPanel(
      p("Create demographic maps with information from the 2010 US Census."),
      
      selectInput("selecter",
                  label = "Choose a variable to display",
                  choices = c("Percent White", "Percent Black", "Percent Hispanic", "Percent Asian"),
                  selected = "Percent White"
                  ),
      
      sliderInput("slider",
                  label = "Range of interest:",
                  min = 0,
                  max = 100,
                  value = c(0,100)
                  )
    ),
    mainPanel()
  )
))