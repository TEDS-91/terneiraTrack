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
      label = "Fa\u00e7a o upload do arquivo",
      accept = c(".xlsx")
    ),
    uiOutput(ns("sheet_selector")), # Dynamic menu for selecting sheets
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
    # Reactive object to store the uploaded file path
    uploaded_file <- reactive({
      req(input$file) # Ensure a file is uploaded
      input$file$datapath
    })
    # displaying the data
    output$data_table <- DT::renderDataTable({
      data_uploaded()
    })
    # Read the sheet names and display them as options
    output$sheet_selector <- renderUI({
      req(uploaded_file()) # Ensure the file is uploaded
      # Get sheet names
      sheets <- readxl::excel_sheets(uploaded_file())
      # Create a dropdown menu for selecting a sheet
      selectInput(ns("sheet"), "Selecione a aba:", choices = sheets)
    })
    data_uploaded <- reactive({
      req(uploaded_file(), input$sheet) # Ensure a file and sheet are selected
      # Read the data from the selected sheet
      data <- readxl::read_excel(uploaded_file(), sheet = input$sheet)
      data
    })
    # whole spreadsheet to be available for reporting and DataViz
    whole_spreadsheet <- reactive({
      req(uploaded_file()) # Ensure a file is uploaded
      # Read the data from the selected sheet
      sheets <- readxl::excel_sheets(uploaded_file())
      data <- lapply(sheets, function(x) {
        readxl::read_excel(uploaded_file(), sheet = x)
      }) |>
        stats::setNames(sheets)
      data
    })
    # returning the dataset
    return(
      list(
        data_uploaded = reactive(whole_spreadsheet())
      )
    )
  })
}

## To be copied in the UI
# mod_fileUploader_ui("fileUploader_1")

## To be copied in the server
# mod_fileUploader_server("fileUploader_1")
