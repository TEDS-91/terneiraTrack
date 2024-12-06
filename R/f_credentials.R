#' @title Credentials.
#'
#' @return A data frame with the credentials.
#' @export
#'
credentials <- function() {
  credentials <- data.frame(
    user = c("joao_costa", "tadeu_eder", "consultor_one", "consultor_two"), # mandatory
    password = c("12345", "12345", "12345", "12345"), # mandatory
    start = c("2024-01-01"), # optinal (all others)
    expire = c(NA, NA, NA, NA),
    admin = c(TRUE, TRUE, NA, NA),
    comment = "Simple and secure authentification mechanism
  for single Shiny applications.",
  stringsAsFactors = FALSE
  )
  return(credentials)
}
