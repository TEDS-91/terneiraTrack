#' report UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_report_ui <- function(id) {
  ns <- NS(id)
  tagList(
    downloadButton(ns("report"), "Generate report"),
    fileInput(ns("logo"),
              "Fa\u00e7a upload do logo:",
              accept = c("image/png", "image/jpeg")),
    tableOutput(ns("data_table_teste"))
  )
}

#' report Server Functions
#'
#' @noRd
mod_report_server <- function(id, growth_data) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    output$data_table_teste <- renderTable({
      growth_data
    })

    output$report <- downloadHandler(
      "report.html",
      content = function(file) {
        path_qmd <- system.file("app/report", "report.qmd", package = "terneiraTrack")
        path_html <- system.file("app/report", "report.html", package = "terneiraTrack")
        quarto::quarto_render(
          input = path_qmd,
          output_format = "html",
          execute_params = list(
            growth_data = growth_data,
            logo = input$logo$datapath
          ),
          execute_dir = system.file("app/report", package = "terneiraTrack")
        )
        # copy the quarto generated file to `file` argument.
        generated_file_name <- path_html
        file.copy(generated_file_name, file)
      }
    )
  })
}

## To be copied in the UI
# mod_report_ui("report_1")

## To be copied in the server
# mod_report_server("report_1")
