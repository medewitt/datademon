#' Chi Square Plotter
#' @md
#' This function quickly plots a summarised plot for outlier detection with numeric variables
#' @param  input_df a dataframe with named rows
#'
#' @export
#' @rdname chi_square_plotter


chi_square_plotter <- function(input_df){

  numeric_vars <- as.matrix(dplyr::select_if(input_df, is.numeric))

  input_df <- numeric_vars

  cm <- colMeans(input_df)

  S <- cov(input_df)

  solver <- function(x) {t(x - cm) %*% solve(S) %*% (x-cm)}

  d <- apply(input_df, 1, solver)

  plot(qc <-qchisq((1:nrow(input_df) -1/2)/nrow(input_df), df = 6),
       sd <- sort(d),
       xlab = expression(paste(chi[6]^2), "quantile"),
       ylab = "Ordered Distances", xlim = range(qc)*c(1,1.1))

  oups <-which(rank(abs(qc - sd), ties = "random") > nrow(x) -3)
  text(qc[oups], sd[oups] - 1.5, names(oups))
  abline(a = 0, b = 1)
}
