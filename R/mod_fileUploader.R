#' fileUploader UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_fileUploader_ui <- function(id) {
  ns <- NS(id)
  tagList(
    fileInput(ns("file"),
      label = "Faça o upload do arquivo",
      accept = c(".xlsx")
    ),
    bs4Dash::bs4Card(
      title = "Dados do arquivo",
      status = "primary",
      solidHeader = TRUE,
      width = 12,
      DT::dataTableOutput(ns("data_table"))
    )
  )
}

#' fileUploader Server Functions
#'
#' @noRd
mod_fileUploader_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    # capturing the file
    data_uploaded <- reactive({
      req(input$file)
      readxl::read_xlsx(input$file$datapath)
    })
    # displaying the data
    output$data_table <- DT::renderDataTable({
      data_uploaded()
    })
  })
}

## To be copied in the UI
# mod_fileUploader_ui("fileUploader_1")

## To be copied in the server
# mod_fileUploader_server("fileUploader_1")
