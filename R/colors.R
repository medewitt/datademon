wake_palette <- c("#9E7E38", "#000000","#82231C", "#511536", "#443E67", "#375669", "#456525", "#59786C", "#3D3C1D", "#625750")
#' Wake Forest Branded Color Pallete
#' @export
#' @example
#' library(scales)
#' scales::show_col(wake_pal()(9))
#'
wake_pal <- function(){ scales::manual_pal(wake_palette)}

#' Discrete color & fill scales based on the ipsum palette
#'
#' See [wake_pal]().
#'
#' @md
#' @inheritParams ggplot2::scale_colour_hue
#' @rdname scale_wake
#' @export
scale_colour_wake <- function(...) { discrete_scale("colour", "wake", wake_pal(), ...) }

#' @export
#' @rdname scale_wake
scale_color_wake <- scale_colour_wake

#' @export
#' @rdname scale_wake
scale_fill_wake <- function(...) { discrete_scale("fill", "wake", wake_pal(), ...) }

