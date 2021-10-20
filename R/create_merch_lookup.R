#' Create ABS Lookup table for merchandise exports data
#'
#' The ABS merchandise exports data
#' (\url{https://stat.data.abs.gov.au/index.aspx?DatasetCode=MERCH_EXP}) is
#' supplied with short codes for various data fields, such as industry and
#' SITC code. This function creates a series of lookup tables that include
#' English descriptions of these fields.
#'
#' @return A list, each element of which is a `tbl_df`
#'

create_merch_lookup <- function() {
  url <- "https://stat.data.abs.gov.au/restsdmx/sdmx.ashx/GetDataStructure/MERCH_EXP"

  lookup <- readsdmx::read_sdmx(url) %>%
    dplyr::as_tibble()

  lookup <- lookup %>%
    dplyr::filter(.data$en %in% c(
      "State of Origin",
      "Commodity by SITC",
      "Industry of Origin (ANZSIC06)",
      "Country of Destination"
    )) %>%
    dplyr::select(.data$en,
      desc = .data$en_description,
      parent_code = .data$parentCode,
      .data$value
    )

  lookup <- lookup %>%
    dplyr::mutate(en = dplyr::case_when(
      .data$en == "Country of Destination" ~ "country",
      .data$en == "State of Origin" ~ "region",
      .data$en == "Industry of Origin (ANZSIC06)" ~ "industry",
      .data$en == "Commodity by SITC" ~ "sitc_rev3"
    ))

  lookup <- lookup %>%
    dplyr::group_by(.data$en)

  lookup_groups <- lookup %>%
    dplyr::group_keys() %>%
    dplyr::pull()

  lookup <- lookup %>%
    dplyr::group_split()

  lookup <- stats::setNames(lookup, lookup_groups)

  lookup <- purrr::imap(
    lookup,
    ~ tidyr::pivot_wider(
      data = .x,
      names_from = "en",
      values_from = "value"
    ) %>%
      dplyr::rename("{.y}_desc" := .data$desc) %>%
      dplyr::select(-.data$parent_code) %>%
      dplyr::distinct()
  )

  lookup
}
