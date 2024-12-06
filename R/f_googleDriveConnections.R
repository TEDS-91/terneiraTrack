#' @title Create a Google Sheet.
#'
#' @param folder_id Folder ID.
#' @param sheet_name Sheet name.
#' @param template Template.
#'
#' @return A Google Sheet.
#' @export
#'
create_new_sheet <- function(folder_id, sheet_name, template) {
  gs4_create_at(name = sheet_name,
    path = googledrive::as_id(folder_id),
    sheets = template
  )
}

#' @title List the farms in a folder.
#'
#' @param folder_id Folder ID.
#'
#' @return A list of farms.
#' @export
#'
list_farms <- function(folder_id) {
  googledrive::drive_ls(googledrive::as_id(folder_id))
}

#' @title List the sheets in a folder.
#'
#' @param path Path.
#' @param name Name.
#' @param sheets Sheets.
#' @param overwrite Overwrite.
#' @param ... ...
#'
#' @return A Google Sheet.
#' @export
#'
gs4_create_at <- function(path = NULL,
                          name = gs4_random(),
                          sheets = NULL,
                          overwrite = NA,
                          ...
) {

  ss <- googlesheets4::gs4_create(name = name, sheets = sheets, ...)

  googledrive::drive_mv(ss, path = path, name = name, overwrite = overwrite)

  ss
}
