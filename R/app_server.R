#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic

  # call the server part
  # check_credentials returns a function to authenticate users
  res_auth <- shinymanager::secure_server(
    check_credentials = shinymanager::check_credentials(credentials())
  )

  output$auth_output <- renderPrint({
    reactiveValuesToList(res_auth)
  })

  mod_farmRegistration_server("farmRegistration_1", user_name = res_auth$user)

  data <- mod_fileUploader_server("fileUploader_1")

  # output$data_table_teste <- DT::renderDataTable({
  #   data$data_uploaded()[[2]]
  # })

  mod_calfGrowth_server("calfGrowth_1",
    growth_data = data$data_uploaded()[[2]]
  )

  mod_report_server("report_1",
    growth_data = data$data_uploaded()[[2]]
  )

  mod_templateFile_server("templateFile_1")
}
