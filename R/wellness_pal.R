devtools::use_package("ggplot2")
devtools::use_package("extrafont")
devtools::use_package("scales")
devtools::use_package("RColorBrewer")
devtools::use_package("dplyr")

library(RColorBrewer)
wellness_palette <- RColorBrewer::brewer.pal(name = "BuPu", n = 8)[2:8]
#' Wake Forest Branded Color Pallete
#' @export
#' @example
#' library(scales)
#' scales::show_col(wellness_pal()(7))
#'
wellness_pal <- function(){ scales::manual_pal(wellness_palette)}


#' Discrete color & fill scales based on the wellness palette
#'
#' See [wellness_pal]().
#'
#' @md
#' @inheritParams ggplot2::scale_colour_hue
#' @rdname scale_wellness
#' @export
scale_colour_wellness <- function(...) { discrete_scale("colour", "wellness",
                                                        wellness_pal(), ...) }

#' @export
#' @rdname scale_wellness
scale_color_wellness <- scale_colour_wellness

#' @export
#' @rdname scale_wellness
scale_fill_wellness <- function(...) { discrete_scale("fill", "wellness",
                                                      wellness_pal(), ...) }


