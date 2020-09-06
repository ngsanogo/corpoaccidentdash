#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinydashboard
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here 
    dashboardPage(
      dashboardHeader(title = "Corpoaccidentdash"),
      dashboardSidebar(
        sliderInput("an", "Année",
                    min = 2000 + min(corpoaccident::carac$an),
                    max = 2000 + max(corpoaccident::carac$an),
                    value = 1, step = 1, ticks = TRUE
        ),
        sidebarMenu(
          menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
          menuItem("Tables statistiques", tabName = "table", icon = icon("fas fa-table")),
          menuItem("Base de données", tabName = "data", icon = icon("fas fa-database"))
        )
      ),
      dashboardBody(
        tabItems(
          # First tab content
          tabItem(tabName = "dashboard",
                  fluidRow(
                    valueBoxOutput("vbox"),
                    valueBoxOutput("vbox2"),
                    valueBoxOutput("vbox3")
                  )
          ),
          
          # Second tab content
          tabItem(tabName = "table",
                  h2("Widgets tab content"),
                  fluidRow(
                    box(plotOutput("plot1", height = 250)),
                    
                    box(
                      title = "Controls",
                      sliderInput("slider", "Number of observations:",
                                  1, 100, 50)
                    )
                  )
          ),
          
          # Third tab content
          tabItem(tabName = "data",
            h2("Data"),
            selectInput("type", "Base de données",
                        choices = c("carac", "lieu", "usager", "vehicule")),
            dataTableOutput("corpo")
          )
        )
      )
    )
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

