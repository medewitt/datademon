#' Load extrat fonts
#' @md
#' This is a tool that can be used to load windows fonts because R gets weird with them

#' @export
#' @rdname create_fonts

library(extrafont)

create_fonts <- function(){extrafont::loadfonts(device = "win")}

