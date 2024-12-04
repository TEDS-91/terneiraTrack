#' @title Generate Header of Quarto Report.
#'
#' @param propriedade Farm name.
#' @param fazendeiro Farmer name.
#' @param localidade Location.
#' @param tecnico Technician.
#' @param data Visit date.
#'
#' @return
#' @export
#'
generate_header <- function(propriedade,
                            fazendeiro,
                            localidade,
                            tecnico,
                            data) {
  html <- glue::glue(
    '<table style="width: 100%; border-collapse: collapse; margin-bottom: 20px; border: 1px solid #ddd;">
      <tr>
        <td style="width: 50%; padding: 10px; border-right: 1px solid #ddd;">
          <p><strong>Fazenda:</strong> {propriedade}</p>
          <p><strong>Fazendeiro:</strong> {fazendeiro}</p>
          <p><strong>Localidade:</strong> {localidade}</p>
        </td>
        <td style="width: 50%; padding: 10px;">
          <p><strong>T\u00e9cnico Respons\u00e1vel:</strong> {tecnico}</p>
          <p><strong>Data da Visita:</strong> {data}</p>
        </td>
      </tr>
    </table>'
  )

  htmltools::HTML(html)
}

#' @title Generate Logo Header of Quarto Report.
#'
#' @param consultoria Consulting name.
#' @param logo Path to the logo.
#'
#' @return
#' @export
#'
generate_logo_header <- function(consultoria, logo) {
  html <- glue::glue(
    '<div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #ccc; padding-bottom: 10px;">
      <div>
        <h1 style="margin: 0;">{consultoria}</h1>
      </div>
      <div>
        <img src="{logo}" alt="Logo" style="height: 80px;">
      </div>
    </div>'
  )

  htmltools::HTML(html)
}



