#' @title Generate a list of EML-compliant coordinate reference system (CRS)
#' names
#'
#' @description list_crs is a helper function that provides convenient access
#' to a list of EML-compliant coordinate references systems (CRSs) by querying
#' the authoritative NCEAS EML schema directly.
#'
#' @importFrom xml2 read_html xml_contents xml_find_all xml_attr
#'
#' @return A character vector of EML-compliant coordinate reference system
#' names. These values are valid inputs to the \code{coord_sys} parameter of
#' \code{\link{create_vector_shape}} and \code{\link{package_vector_shape}}.
#'
#' @examples
#' \dontrun{
#'
#' # retrieve the full list of EML-compliant CRS names
#' crs_names <- capemlVector::list_crs()
#'
#' # search for UTM zone options
#' crs_names[grepl("UTM", crs_names)]
#'
#' }
#'
#' @export
#'
list_crs <- function() {

  crs_list_raw <- tryCatch(
    xml2::read_html(
      x = "https://raw.githubusercontent.com/NCEAS/eml/main/xsd/eml-spatialReference.xsd"
    ),
    error = function(e) {
      stop(
        "could not retrieve CRS list from NCEAS EML schema. ",
        "Check your internet connection or visit: ",
        "https://raw.githubusercontent.com/NCEAS/eml/main/xsd/eml-spatialReference.xsd",
        call. = FALSE
      )
    }
  )

  crs_list_contents <- xml2::xml_contents(x = crs_list_raw)

  crs_list <- xml2::xml_find_all(
    x     = crs_list_contents,
    xpath = "//element[@name = 'horizCoordSysName']"
    ) |>
    xml2::xml_find_all(xpath = ".//enumeration") |>
    xml2::xml_attr(attr = "value")

  return(crs_list)

}
