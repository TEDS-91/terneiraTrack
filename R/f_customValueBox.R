#' Custom Vale Box.
#'
#' @param value.
#' @param name.
#' @param change.
#' @param unit
#'
#' @return
#' @export
#'
#' @examples
#' customValueBox(100, "Test", 10, "kg")
customValueBox <- function(value, name, change, unit = "") {
  icon <- if (change >= 0) {
    paste0('<i class="fa fa-arrow-up" style="color:green;">', formatC(change, format = "f", digits = 2), "%</i>")
  } else {
    paste0('<i class="fa fa-arrow-down" style="color:red;">', formatC(abs(change), format = "f", digits = 2), "%</i>")
  }

  html <- paste0(
    '<div style="padding: 20px; background-color: #f8f8f8; border-radius: 10px; box-shadow: 0 0 15px rgba(0,0,0,0.15); font-family: Helvetica; height: 120px; display: flex; flex-direction: column; justify-content: space-between;">',
    '<div style="font-size: 16px; color: #333;">', name, "</div>",
    '<div style="display: flex; align-items: center; justify-content: space-between; flex-grow: 1;">',
    '<span style="font-size: 24px; font-weight: bold;">', value, " ", unit, "</span>",
    '<span style="font-size: 16px;">', icon, "</span>",
    "</div>",
    "</div>"
  )

  htmltools::HTML(html)
}
