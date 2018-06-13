#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(rlang)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  # ファイルをアップロードしたときの動作
  observeEvent(input$file, {

    # データの読み込み
    csv_file <<- reactive(read.table(input$file$datapath, sep = "\t", header = T, fileEncoding = "utf-8"))

    # 3-5列目のカラム名を取得して、選択肢として表示する
    columns_list <- colnames(csv_file())[3:5]

    output$columns_list <- renderUI({
      selectInput("selected_layer",
                  label = h3("layer"),
                  choices = as.list(columns_list),
                  selected = columns_list[1])
    })

    # 年度を取得して、選択肢として表示する
    year_list <- unique(csv_file()[[1]])

    output$year_list <- renderUI({
      checkboxGroupInput("years",
                   label = h3("Years"),
                   choices = as.list(year_list),
                   selected = year_list[1])
    })
  })

  # submitを押すと選択した条件に基づいて新しいデータを作成する
  # submitを押すまでは条件を変更してもグラフには反映されない
  output_data <- eventReactive(input$submit, {

    if(is.null(input$selected_layer) | is.null(input$years))
      return()

    # dplyr::filter()の引数に変数を使うための処理
    year_ <- colnames(csv_file())[1] %>%
      rlang::sym()
    sales_ <- colnames(csv_file())[6]

    # salesの方は引数に変数を使用する対応はまだ
    csv_file() %>%
      dplyr::filter((!!year_) %in% input$years) %>%
      dplyr::group_by_(input$selected_layer) %>%
      dplyr::summarise(sum_sales=sum(sales))

  })

  # submitを押したときに選択していた条件を変数に格納
  selected_cond <- eventReactive(input$submit, {

    if(is.null(input$selected_layer) | is.null(input$years))
      return()

    input$selected_layer
  })

  # submitを押したときに作成されたデータと条件に基づいてグラフを作成
  output$plot <- renderPlot({
    p <- ggplot(output_data(), aes_(x = as.name(selected_cond()), y = as.name("sum_sales"))) %>% #グラフのベース
          + geom_bar(stat = "identity") %>% #棒グラフ
          + theme(axis.text.x = element_text(angle = 45, hjust = 1)) #x軸ラベルの回転
    print(p)
  })

})
