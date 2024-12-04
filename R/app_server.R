#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic
  data <- mod_fileUploader_server("fileUploader_1")

  output$data_table_teste <- DT::renderDataTable({
    data$data_uploaded()[[2]]
  })

  mod_report_server("report_1", growth_data = data$data_uploaded()[[2]])

  mod_templateFile_server("templateFile_1")
}
