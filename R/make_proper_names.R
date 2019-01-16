#' make_titles

#'@export
make_proper_names <- function(x){
  proper_names <- x
  proper_names <- tolower(proper_names)
  proper_names <- gsub("[[:space:][:punct:]]+", " ", proper_names)
  proper_names <- trimws(proper_names)
  proper_names <- gsub(" ", "_", proper_names)
  proper_names
}
