#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinydashboard
#' @noRd
app_ui <- function(request) {
  # Header
  header <- dashboardHeader(title = "Corpoaccidentdash")
  # Sidebar
  sidebar <- dashboardSidebar(
    sliderInput("an", "Année",
                min = 2000 + min(corpoaccident::carac$an),
                max = 2000 + max(corpoaccident::carac$an),
                value = 1, step = 1, ticks = TRUE
    ),
    # Menu
    sidebarMenu(
      menuItem("Dashboard", tabName = "dash", icon = icon("dashboard")),
      menuItem("Data", tabName = "rawdata", icon = icon("fas fa-database")),
      menuItem("Apropos", tabName = "apropos", icon = icon("fas fa-table"))
    )
  )
  
  body <- dashboardBody(
    tabItems(
      # Dashbord
      tabItem(tabName = "dash",
              fluidRow(
                valueBoxOutput("vbox"),
                valueBoxOutput("vbox2"),
                valueBoxOutput("vbox3")
              ),
              
              fluidRow(
                box(
                  "Map"
                ),
                box(
                  "hist1"
                )
              )
      ),
      
      # Database
      tabItem(tabName = "rawdata",
              selectInput("db", label = "Table",
                          choices = c("Caractéristique" = "carac",
                                      "Lieu principal" = "lieu",
                                      "Usager impliqués" = "usager",
                                      "Véhicule" = "vehicule")
                          ),
              tableOutput("data"),
              downloadButton("export", "Télécharger en csv")
      ),
      
      # Apropos
      tabItem(tabName = "apropos",
              includeHTML("inst/app/www/apropos.html")
      )
    )
  )
  
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here
    dashboardPage(header, sidebar, body)
  )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
  
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'corpoaccidentdash'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}
