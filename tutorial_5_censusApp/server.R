# server.R

source("helpers.R")
counties <- readRDS("data/counties.rds")
library(maps)
library(mapproj)

shinyServer(
  function(input, output) {
    
    output$map <- renderPlot({
      data <- switch(input$var,
                     "Percent White" = countries$white,
                     "Percent Black" = countries$black,
                     "Percent Hispanic" = counties$hispanic,
                     "Percent Asian" = counties$asian
                     )
      
      percent_map(var = data,
                  color = "darkgreen",
                  legend.title = input$var,
                  max = input$range[2],
                  min = input$range[1]
                  )
    })
      
  }
)