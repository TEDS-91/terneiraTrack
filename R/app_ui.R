#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    bs4Dash::dashboardPage(
      bs4Dash::dashboardHeader(
        title = "TerneiraTrack"
      ),
      bs4Dash::dashboardSidebar(
        bs4Dash::sidebarMenu(
          bs4Dash::menuItem("Entrada de Dados",
            tabName = "dataEntry",
            icon = icon("dashboard")
          ),
          bs4Dash::menuItem("Widgets",
            tabName = "widgets",
            icon = icon("th")
          )
        )
      ),
      bs4Dash::dashboardBody(
        bs4Dash::tabItems(
          bs4Dash::tabItem(
            tabName = "dataEntry",
            mod_fileUploader_ui("fileUploader_1"),
            h2("Dashboard tab content")
          ),
          bs4Dash::tabItem(
            tabName = "widgets",
            h2("Widgets tab content")
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
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "terneiraTrack"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
