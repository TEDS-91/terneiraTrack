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
      title = "Curva de Crescimento das Bezerras",
      status = "success",
      solidHeader = TRUE,
      collapsible = TRUE,
      width = 12,
      height = "auto",
      footer = tags$p("A linha preta representa o desempenho m\u00e9dio das bezerras.",
                      style = "font-size: 12px; color: grey; text-align: center;"),
      plotly::plotlyOutput(ns("data_types"))
    ),
    bs4Dash::box(
      title = "Dados Brutos da Tabela",
      status = "success",
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
        dplyr::mutate(
          `Num. Bezerra` = as.factor(`Num. Bezerra`),
          "Idade Pesagem (dias)" = as.numeric(difftime(`Data Pesagem`, `Data Nasc.`)),
          "ADG (kg)" = (`Peso (kg)` - `Peso Nasc. (kg)`) / 30
        )
    })

    output$data_types <- plotly::renderPlotly({
      #browser()
      data <- adg_calc() |>
        dplyr::select(`Num. Bezerra`, `Peso Nasc. (kg)`) |>
        dplyr::mutate("Idade Pesagem (dias)" = 0) |>
        dplyr::rename("Peso (kg)" = `Peso Nasc. (kg)`) |>
        dplyr::bind_rows(
          adg_calc() |>
            dplyr::filter(Desmamada == "Nao") |>
            dplyr::select(`Num. Bezerra`, `Peso (kg)`, `Idade Pesagem (dias)`)
        )

      model_gmd <- stats::lm(`Peso (kg)` ~ `Idade Pesagem (dias)`, data = data)

      data |>
        plotly::plot_ly(
          x = ~`Idade Pesagem (dias)`,
          y = ~`Peso (kg)`,
          type = 'scatter',
          mode = 'lines+markers',
          color = ~`Num. Bezerra`,
          split = ~`Num. Bezerra`,
          hoverinfo = "text",
          text = ~paste(
            "Idade (dias):", `Idade Pesagem (dias)`,
            "<br>Peso (kg):", `Peso (kg)`,
            "<br>Num. Bezerra:", `Num. Bezerra`
          )
        ) |>
        plotly::add_lines(
          x = ~`Idade Pesagem (dias)`,
          y = ~(`Idade Pesagem (dias)` * stats::coef(model_gmd)[[2]] + stats::coef(model_gmd)[[1]]),
          name = "Regression Line",
          line = list(color = "black"),
          hoverinfo = "none" # Desativa hover para a linha de regressão
        ) |>
        plotly::layout(
          title = "Rela\u00e7\u00e3o entre Peso e Idade",
          xaxis = list(title = "Idade (dias)"),
          yaxis = list(title = "Peso (kg)"),
          showlegend = FALSE,
          legend = list(orientation = "h", x = 0.5, xanchor = "center", y = -0.2)
        )
    })

    output$growth_kpis <- renderUI({
      bs4Dash::box(
        title = "Principais Indicadores de Desempenho.",
        status = "success",
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
