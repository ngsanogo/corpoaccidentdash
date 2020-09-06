#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output,session) {
  # List the first level callModules here
  set.seed(122)
  histdata <- reactive({
    rnorm(input$an)
  })
  
  output$plot1 <- renderPlot({
    data <- histdata()[seq_len(input$slider)]
    hist(data)
  })
  
  output$vbox <- renderValueBox({
    valueBox(value = format(sum(c(2000 + corpoaccident::carac$an) %in% input$an), big.mark = ","),
             subtitle = "Nombre d'accidents", 
             icon = icon("bar-chart-o"), 
             color = "purple")
  })
  output$vbox2 <- renderValueBox({
    valueBox(value = format(sum(corpoaccident::usager$Num_Acc %in% corpoaccident::carac$Num_Acc[c(2000 + corpoaccident::carac$an) %in% input$an] & corpoaccident::usager$grav %in% "Tué"), big.mark = ","),
             subtitle = "Nombre de décès", 
             icon = icon("bar-chart-o"), 
             color = "purple")
  })
  output$vbox3 <- renderValueBox({
    valueBox(value = format(round(mean((input$an - corpoaccident::usager$an_nais[corpoaccident::usager$grav %in% "Tué"]), na.rm = TRUE)), big.mark = ","),
             subtitle = "Moyenne d'age des personnes décèdées", 
             icon = icon("bar-chart-o"), 
             color = "purple")
  })
  output$corpo <- renderDataTable(
    if (input$type == "carac") {
      corpoaccident::carac
    } else if (input$type == "lieu") {
      corpoaccident::lieu
    } else if (input$type == "usager") {
      corpoaccident::usager
    } else if (input$type == "vehicule") {
      corpoaccident::vehicule 
    })
}
