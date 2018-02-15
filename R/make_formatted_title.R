#' @title ggplot2 Title Break Make
#' @description
#' @details
#' @param title the vector of values you would like to add carriage returns to
#' @param character_width how many characters do you want each line to be maximum
#' @export
#' @examples
#' a <- "A really long title for a graph that will probably not fit but we need to write it all"
#'
#' make_formatted_title(a)
#'
make_formatted_title <-function(title, character_width = 20){
  my_paste <- function(x){
    paste0(x, collapse = "\n")
  }
  titles <-stringr::str_wrap(title, character_width)
  return(titles)
}

