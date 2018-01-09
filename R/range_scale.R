#' A function to scale values based on ranges rather than typical R scale function
#' @param df which contains the numeric values to be scaled via range
#'
#' @return df with the scaled values


range_scale <- function(df){
  rge <- sapply(df, function(x) diff(range(x)))

  crime_s <- sweep(df, 2, rge, FUN = "/")

  return(crime_s)
}
