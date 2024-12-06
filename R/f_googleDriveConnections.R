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
  lbr::gs4_create_at(sheet_name,
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
