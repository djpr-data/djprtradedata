#' Download, tidy and import ABS balance of payments data
#'
#' Downloads ABS Balance of Payments (5302.0) Tables 21 and 22, goods and
#' services credits and debits by state.
#' @param path Path where Excel files from the ABS should be stored
#' @return A tibble containing both imports (debits) and credits (exports)
#' data
#' @examples
#' \dontrun{
#' read_bop()
#' }
#' @export
#' @importFrom dplyr .data

read_bop <- function(path = tempdir()) {
  credits <- readabs::read_abs("5302.0", 21,
                               path = path,
                               check_local = FALSE) %>%
    dplyr::mutate(series = paste("Exports", .data$series, sep = " ; "))

  debits <- readabs::read_abs("5302.0", 22,
                              path = path,
                              check_local = FALSE) %>%
    dplyr::mutate(series = paste("Imports", .data$series, sep = " ; "))

  bop <- dplyr::bind_rows(credits, debits)

  bop <- bop %>%
    dplyr::select(.data$series,
                  .data$date,
                  .data$value,
                  .data$series_id)

  bop %>%
    tidyr::separate(.data$series,
                    into = c("exports_imports",
                             "indicator",
                             "goods_state"),
                    extra = "drop",
                    sep = ";") %>%
    tidyr::separate(.data$goods_state,
                    into = c("goods_services",
                             "state"),
                    sep = ",") %>%
    dplyr::mutate(dplyr::across(!dplyr::one_of(c("date",
                                                   "value",
                                                   "series_id")),
                                ~trimws(.x, "both")
                                )) %>%
    dplyr::filter(!is.na(.data$value))
}
