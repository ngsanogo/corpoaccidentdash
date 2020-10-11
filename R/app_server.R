#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output,session) {
  # List the first level callModules here
  
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
  
  corpodata <- reactive(eval(parse(text = paste0("corpoaccident::", input$db))))
  
  output$data <- renderTable({
    corpodata()
  })
  
  output$export <- downloadHandler(
    filename = paste0(input$db, ".csv"),
    content = function(file) {
      write.csv(corpodata(), file)
    },
    contentType = "text/csv"
  )

}
