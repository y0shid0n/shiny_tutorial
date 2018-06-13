#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# UI
shinyUI(fluidPage(

  # title
  titlePanel("Shiny App for cut-off analysis"),

  # Sidebar
  sidebarLayout(
    sidebarPanel(h2("累積売上"),

                 # 読み込んだファイルから年度を取得して表示
                 uiOutput("year_list"),

                 # 読み込んだファイルからカラム名を取得して表示
                 uiOutput("columns_list"),

                 # ファイルのアップロード
                 fileInput("file",label = h3("File input")),

                 # 変更した条件をグラフに反映させるためのボタン
                 actionButton("submit", "submit")
                 ),

    # mainpanel
    mainPanel(
      plotOutput("plot")
      #,textOutput("text") #デバッグ用
      )

  )
))
