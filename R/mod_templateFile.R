#' templateFile UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_templateFile_ui <- function(id){
  ns <- NS(id)
  tagList(
    downloadButton(ns("file"),
      label = "Fa\u00e7a o download do arquivo"
    )
  )
}

#' templateFile Server Functions
#'
#' @noRd
mod_templateFile_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    # our data template - for now use the mtcars dataset
    data <- mtcars
    # download the data (xlsx format)
    output$file <- downloadHandler(
      filename = function() {
        paste("data-", Sys.Date(), ".xlsx", sep="")
      },
      content = function(file) {
        writexl::write_xlsx(data, file)
      }
    )

  })
}

## To be copied in the UI
# mod_templateFile_ui("templateFile_1")

## To be copied in the server
# mod_templateFile_server("templateFile_1")
