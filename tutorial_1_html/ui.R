library(shiny)

# アプリケーションの UI 定義。ヒストグラムを描く
shinyUI(fluidPage(
  titlePanel(
    strong("My Shiny App")
    ),
  
  sidebarLayout(
    sidebarPanel(
      h1("Installation"),
      p("Shiny is available on CRAN, so you can install it in the usual way from your R console:"),
      code("install.packages(\"shiny\")"),
      br(),
      br(),
      img(src = "RStudio-Ball.png", height = 50, wigth = 50),
      "shiny is a product of ", a(href = "https://www.rstudio.com/", "Rstudio")
    ),
    mainPanel(
      h1("Introducing Shiny"),
      p("Shiny is a new package from RStudio that makes it", em("incredibly easy"), " to build interactive web applications with R."),
      br(),
      p("For an introdiction and live examples, visit the", a(href="https://shiny.rstudio.com/", "Shiny homepage.")),
      br(),
      h2("Features"),
      p("* Build useful web applications with only a few lines of code–no JavaScript required."),
      p("* Shiny applications are automatically \"live\" in the same way that", strong("spreadsheets"), " are live. Outputs change instantly as users modify inputs, without requiring a reload of the browser.")
    )
  )
))