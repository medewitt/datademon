#'@title check missing
#'@param df a data frame to inspect
#'
#'
#'@export


check_missing <- function(df) {
  if (!class(df)[[1]] %in% c("tbl_df", "tbl", "data.frame")) {
    stop("Please pass a dataframe to this function.")
  }

  missings <-
    purrr::map_df(df_matching_raw_1, ~ sum(is.na(.))) %>% gather(column, missings)

  columns_with_missing_data <- missings %>%
    filter(missings > 0) %>%
    select(column) %>%
    unlist()

  if (sum(missings$missings > 0)) {
    stop(paste0("There are missings: ", columns_with_missing_data))
  }
  message("There are no missing values in this data set.")
}
