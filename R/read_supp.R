#' Download, tidy and import ABS International Trade Supplementary Information by Calendar Year
#' 
#' Downloads Tables 1 through 8, inculsive, of the ABS International Trade: Supplementary Information data by Calendar Year.
#' @param table_no Selects which tables from the ABS will be imported
#' @param path Path where Excel files downloaded from the ABS should be stored
#' @return A tibble containing the relevant table, or a list of tibbles if more than one ABS table has been requested
#' @examples
#' \dontrun{
#' read_supp()
#' }
#' @export

read_supp <- function(format = "cy", table_no = c(1, 2, 3, 4, 5, 6, 7, 8), path = tempdir()) {
  temp <- tempfile()

  if (format == "cy"){
    year <- rvest::read_html("https://www.abs.gov.au/statistics/economy/international-trade/international-trade-supplementary-information-calendar-year/latest-release")
  }

  if (format == "fy"){
    year <- rvest::read_html("https://www.abs.gov.au/statistics/economy/international-trade/international-trade-supplementary-information-financial-year/latest-release")
  } 

  year <- rvest::read_html("https://www.abs.gov.au/statistics/economy/international-trade/international-trade-supplementary-information-calendar-year/latest-release")

  year_url <- year %>%
    rvest::html_nodes("a") %>%
    rvest::html_attr("href") %>%
    stringr::str_subset(".zip")

  download.file(year_url, temp)

  unzip(temp, exdir = path)

  unlink(temp)

  file_no <- length(list.files(path = path, pattern = "*.xls"))

  if (file_no >= 15) {
    file_no <- 0.5 * file_no
  }

  tables <- vector(mode = "list", length = file_no)

  year_output <- vector(mode = "list", length = file_no)

  extract_files <- lapply(
    list.files(path = path, pattern = "*.xls"),
    readabs::extract_abs_sheets
  )

  for (j in 2:file_no - 1) {
    year_files <- extract_files[[j]]

    tables[[j]] <- matrix(1, length(year_files) - 1)

    for (i in 2:length(year_files) - 1) {
      temp_table <- year_files[[i + 1]]
      names(temp_table) <- as.character(tidyr::drop_na(temp_table)[1, ])
      series <- temp_table[3, 1]
      header_row <- -which(temp_table[, 1] == as.character(head(tidyr::drop_na(temp_table), n = 1)[, 1]))
      footer_row <- which(temp_table[, 1] == as.character(tail(tidyr::drop_na(temp_table), n = 1)[, 1])) - nrow(temp_table)
      temp_table <- tail(head(temp_table, footer_row), header_row) %>%
        tidyr::gather("year", "trade", 2:ncol(temp_table))
      temp_table[, "subset"] <- rep(stringr::word(gsub("\\s*\\([^\\)]+\\)", "", series), -1), nrow(temp_table))
      temp_table[, "abs_series"] <- rep(as.character(series), nrow(temp_table))
      names(temp_table)[1] <- "item"
      assign(paste0("table_", j, ".", i), temp_table)
      tables[[j]][i] <- paste0("table_", j, ".", i)
      rm(header_row)
      rm(footer_row)
      rm(temp_table)
      rm(i)
    }

    year_output[[j]] <- do.call("rbind", lapply(tables[[j]], as.name))
  }

  if (length(year_output[table_no]) == 1) {
    year_output[table_no][[1]]
  } else {
    year_output[table_no]
  }
}
