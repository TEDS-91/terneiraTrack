#' farmRegistration UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_farmRegistration_ui <- function(id) {
  ns <- NS(id)
  tagList(
    bs4Dash::box(
      title = "Adi\u00e7\u00e3o de Fazendas",
      status = "success",
      solidHeader = TRUE,
      collapsible = TRUE,
      width = 12,
      height = "auto",
      fluidRow(
        column(
          3,
          # buttom to create a new farm
          actionButton(ns("new_farm"), "Nova Fazenda", icon = icon("plus"))
        ),
        column(
          3,
          # see specific farm
          actionButton(ns("see_farms"), "Ver Fazendas", icon = icon("eye")),
        ),
        column(
          3,
          # see specific farm
          selectInput(ns("select_farm"), "Selecione a Fazenda", choices = c("Fazenda 1", "Fazenda 2", "Fazenda 3")),
        ),
        column(
          3,
          # buttom to edit a farm
          actionButton(ns("edit_farm"), "Editar Fazenda", icon = icon("edit"))
        ),
        DT::DTOutput(ns("sheets_table"))
      )
    )
  )
}

#' farmRegistration Server Functions
#'
#' @noRd
mod_farmRegistration_server <- function(id, user_name) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    # Server logic

    # determining the consultant based on the urls
    consultant_df <- tibble::tribble(
      ~consultant, ~url,
      "consultor_one", "https://drive.google.com/drive/folders/121exShqOW9w5nEAkAfio2nTgnFsb7hXm",
      "consultor_two", "https://drive.google.com/drive/folders/1b5LNbkogdh_VrE-D12aXwGIBmktLas5G"
    )

    folder <- reactive({
      folder <- googledrive::drive_get(consultant_df |>
                                         dplyr::filter(consultant == user_name) |>
                                         dplyr::pull(url))
    })

    observeEvent(input$new_farm, {
      showModal(
        modalDialog(
          textInput(ns("farm_name"), "Nome da Fazenda"),
          actionButton(ns("create_farm"), "Criar Fazenda"),
          easyClose = TRUE
        )
      )
    })

    observeEvent(input$create_farm, {
      req(input$farm_name)
      # Show a notification that the process is ongoing
      notification_id <- showNotification(
        paste0("Criando fazenda ", input$farm_name,". Por favor espere."),
        type = "message",  # Corrected type
        duration = NULL    # Keeps the notification visible until manually removed
      )
      # Perform the farm creation process
      create_new_sheet(folder()$id, input$farm_name, farm_template_gs())
      # Remove the modal dialog after completion
      removeModal()
      # Remove the ongoing notification
      removeNotification(notification_id)
      # Optional: Show a success notification
      showNotification("Fazenda Criada com sucesso!", type = "default", duration = 5)
    })

    # Render the updated list of sheets in the UI
    list_of_farms <- reactive({
      req(folder()$id)  # Ensure the folder ID is available

      # Fetch the list of sheets and return the names as a data frame
      data.frame("fazendas" = list_farms(folder()$id)$name)
    }) |>
      bindEvent(input$create_farm, input$see_farms)

    output$sheets_table <- DT::renderDT({
      list_of_farms()
    })


  })
}

## To be copied in the UI
# mod_farmRegistration_ui("farmRegistration_1")

## To be copied in the server
# mod_farmRegistration_server("farmRegistration_1")
