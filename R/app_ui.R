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
      freshTheme = app_theme(),
      bs4Dash::dashboardHeader(
        # title = bs4Dash::dashboardBrand(
        # title = "TerneiraTrack",
        # color = "success",
        # href = "https://www.google.fr",
        # image = "https://adminlte.io/themes/AdminLTE/dist/img/user2-160x160.jpg",
        # )
      ),
      bs4Dash::dashboardSidebar(
        skin = "light",
        status = "success",
        bs4Dash::sidebarUserPanel(
          image = "https://image.flaticon.com/icons/svg/1149/1149168.svg",
          name = "TerneiraTrack"
        ),
        bs4Dash::sidebarMenu(
          bs4Dash::menuItem("Entrada de Dados",
            tabName = "dataEntry",
            icon = icon("th")
          ),
          bs4Dash::menuItem("Dashboard",
            icon = icon("dashboard"),
            bs4Dash::menuSubItem(
              text = "Performance",
              tabName = "performance",
              icon = icon("cow")
            ),
            bs4Dash::menuSubItem(
              text = "Sa\u00fade",
              tabName = "health",
              icon = icon("suitcase-medical")
            )
          ),
          bs4Dash::menuItem("Relat\u00f3rio",
            tabName = "report",
            icon = icon("file")
          ),
          bs4Dash::menuItem("Template e Dicas de Uso",
            tabName = "settings",
            icon = icon("cogs")
          )
        )
      ),
      bs4Dash::dashboardBody(
        bs4Dash::tabItems(
          bs4Dash::tabItem(
            tabName = "dataEntry",
            mod_farmRegistration_ui("farmRegistration_1"),
            mod_fileUploader_ui("fileUploader_1"),
            verbatimTextOutput("auth_output"),
            h2("Data Entry tab content")
          ),
          bs4Dash::tabItem(
            tabName = "performance",
            mod_calfGrowth_ui("calfGrowth_1"),
            # DT::dataTableOutput("data_table_teste")
          ),
          bs4Dash::tabItem(
            tabName = "health",
            h2("Health tab content")
          ),
          bs4Dash::tabItem(
            tabName = "report",
            mod_report_ui("report_1"),
            h2("Reports tab content")
          ),
          bs4Dash::tabItem(
            tabName = "settings",
            mod_templateFile_ui("templateFile_1"),
            h2("Settings tab content")
          )
        )
      )
    )
  )
}

# Wrapping the UI with secure_app
app_ui <- shinymanager::secure_app(app_ui)

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
