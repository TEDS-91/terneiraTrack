#' calfGrowth UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_calfGrowth_ui <- function(id) {
  ns <- NS(id)
  tagList(
    h2("Calf Growth tab content"),
    uiOutput(ns("growth_kpis")),
    bs4Dash::box(
      title = "Dados brutos da tabela",
      status = "primary",
      solidHeader = TRUE,
      collapsible = TRUE,
      width = 12,
      height = "auto",
      DT::dataTableOutput(ns("data_table_teste"))
    )
  )
}

#' calfGrowth Server Functions
#'
#' @noRd
mod_calfGrowth_server <- function(id, growth_data) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    adg_calc <- reactive({
      growth_data |>
        dplyr::mutate("ADG (kg)" = (`Peso (kg)` - `Peso Nasc. (kg)`) / 30)
    })

    output$growth_kpis <- renderUI({
      bs4Dash::box(
        title = "KPIs",
        status = "primary",
        solidHeader = TRUE,
        collapsible = TRUE,
        width = 12,
        height = "auto",
        fluidRow(
          column(
            3,
            customValueBox(
              value = length(unique(adg_calc()$`Num. Bezerra`)),
              name = "N\u00ba de Bezerras:", change = 10
            ),
          ),
          column(
            3,
            customValueBox(
              value = round(mean(adg_calc()$`Peso Nasc. (kg)`), 2),
              name = "Peso M\u00e9dio Nasc.:", change = 10, unit = "kg"
            )
          ),
          column(
            3,
            customValueBox(
              value = round(mean(adg_calc()$`ADG (kg)`), 3),
              name = "ADG:", change = 10, unit = "kg"
            )
          ),
          column(
            3,
            customValueBox(
              value = round(mean(adg_calc()$`Idade ao Desm.`, na.rm = TRUE), 2),
              name = "Idade M\u00e9dia ao Desaleitamento:", change = 10, unit = "dias"
            )
          )
        )
      )
    })

    output$data_table_teste <- DT::renderDT({
      adg_calc()
    })
  })
}

## To be copied in the UI
# mod_calfGrowth_ui("calfGrowth_1")

## To be copied in the server
# mod_calfGrowth_server("calfGrowth_1")
