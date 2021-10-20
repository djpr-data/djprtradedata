#' Download merchandise exports data
#'
#' Obtains merchandise exports data from ABS.Stat
#' (\url{https://stat.data.abs.gov.au/index.aspx?DatasetCode=MERCH_EXP}).
#'
#' @details The ABS will not supply data frames of over 1m rows using the
#' ABS.Stat API. For this reason, you cannot download more than 1 year at a
#' time worth of data using this function, as this is around the point at which
#' the 1m row limit is reached.
#' @param min_date The minimum date to include in your data
#' @param max_date The maximum date to include in your data
#' @examples
#' \dontrun{
#' read_merch()
#' }
#' @export
#' @return A tibble containing merchandise export data


read_merch <- function(min_date = Sys.Date() - 365,
                       max_date = Sys.Date()) {
  if (max_date - min_date > 365) {
    stop("Cannot download more than 12 months worth of data at a time due to ABS limits.")
  }

  url <- paste0(
    "https://stat.data.abs.gov.au/restsdmx/sdmx.ashx/GetData/MERCH_EXP/-+2/all?startTime=",
    format(min_date, "%Y-%m"),
    "&endTime=",
    format(max_date, "%Y-%m")
  )

  file <- tempfile(fileext = ".xml")

  utils::download.file(url,
    file,
    mode = "wb"
  )

  merch <- readsdmx::read_sdmx(file) %>%
    dplyr::as_tibble()

  names(merch) <- tolower(names(merch))

  merch <- merch %>%
    dplyr::select(.data$country,
      .data$industry,
      .data$sitc_rev3,
      .data$time,
      .data$region,
      value = .data$obsvalue
    )

  if (nrow(merch) == 1000000) {
    warning(
      "The ABS has supplied a dataframe with exactly 1,000,000 rows, which suggests your request is too big and has been truncated."
    )
  }

  suppressMessages(
    purrr::reduce(
      .x = c(list(merch), lookup),
      .f = dplyr::left_join
    )
  )
}
