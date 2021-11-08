#' Download, tidy and import ABS International Trade Supplementary Information
#'
#' Downloads Tables 1 through 8, inculsive, of the ABS International Trade: Supplementary Information data.
#' @param format Selects whether calendar year or financial year data is imported
#' @param table_no Selects which tables from the ABS will be imported
#' @param list Where multiple tables are requested, if list is TRUE, table outputs exported separately in a list, if FALSE tables are exported in a combined tibble.
#' @param path Path where Excel files downloaded from the ABS should be stored
#' @return A tibble containing the relevant table, or a list of tibbles if more than one ABS table has been requested
#' @examples
#' \dontrun{
#' read_supp()
#' }
#' @export

read_supp <- function(format = "cy", table_no = c(1, 2, 3, 4, 5, 6, 7, 8), list = FALSE, path = tempdir()) {
  if (format == "cy"){
    readabs::download_abs_data_cube("international-trade-supplementary-information-calendar-year",
                         "zip",
                         path)
  }

  if (format == "fy"){
    readabs::download_abs_data_cube("international-trade-supplementary-information-financial-year",
                         "zip",
                         path)
  }

  table_no <- unique(table_no)

  file_name <- list.files(path)[grepl("zip",list.files(path))]
  utils::unzip(file.path(path, file_name), exdir = path)

  file_no <- length(list.files(path = path, pattern = "*.xls"))

  tables <- vector(mode = "list", length = file_no)

  year_output <- vector(mode = "list", length = file_no)

  extract_files <- lapply(
    list.files(path, pattern = "*.xls"),
    readabs::extract_abs_sheets
  )

  unlink(paste0(path, "\\", list.files(path)))

  for (j in 2:file_no - 1) {
    year_files <- extract_files[[j]]

    tables[[j]] <- matrix(1, length(year_files) - 1)

    for (i in 2:length(year_files) - 1) {
      temp_table <- year_files[[i + 1]]
      names(temp_table) <- as.character(tidyr::drop_na(temp_table)[1, ])
      series <- temp_table[3, 1]
      header_row <- -which(temp_table[, 1] == as.character(utils::head(tidyr::drop_na(temp_table), n = 1)[, 1]))
      footer_row <- which(temp_table[, 1] == as.character(utils::tail(tidyr::drop_na(temp_table), n = 1)[, 1])) - nrow(temp_table)
      temp_table <- utils::tail(utils::head(temp_table, footer_row), header_row) %>%
        tidyr::gather("year", "value", 2:ncol(temp_table))
      temp_table[, "subset"] <- rep(stringr::word(gsub("\\s*\\([^\\)]+\\)", "", series), -1), nrow(temp_table))
      temp_table[, "abs_series"] <- rep(as.character(series), nrow(temp_table))
      temp_table <- dplyr::mutate(temp_table, value = as.numeric(value))
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
  if (list == TRUE){
    if (length(year_output[table_no]) == 1) {
      year_output[table_no][[1]]
    } else {
      year_output[table_no]
    }
  }
  if (list == FALSE){
    dplyr::bind_rows(year_output[table_no])
  }
}
