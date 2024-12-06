
#' @title farm_template_gs Function to create the spreasheet.
#'
#' @return A list with the template of the spreadsheet.
#' @export
#'
farm_template_gs <- function() {
  templateSpreadSheet <- list(
    "1- cadastro" = tibble::tibble(
      "Fazenda" = c(NA),
      "Fazendeiro" = c(NA),
      "Localidade" = c(NA)
    ),
    "2- crescimento" = tibble::tibble(
      "Data" = c(NA),
      "Peso" = c(NA),
      "Altura" = c(NA)
    )
  )
}
