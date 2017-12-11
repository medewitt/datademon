#' Chi Square Plotter
#' This function quickly plots a summarised plot for outlier detection with numeric variables
#' @param x a dataframe with named rows
#' @keywords multivariate
#' @keywords chi_square
#' @example
#' chi_square_plotter()


chi_square_plotter <- function(x){

  numeric_vars <- apply(x, 2, is.numeric)

  x <- x[,numeric_vars]

  cm <- colMeans(x)

  S <- cov(x)

  d <- apply(x, 1, function(x) {t(x - cm) %*% solve(S) %*% (x-cm)})

  plot(qc <-qchisq((1:nrow(x) -1/2)/nrow(x), df = 6),
       sd <- sort(d),
       xlab = expression(paste(chi[6]^2), "quantile"),
       ylab = "Ordered Distances", xlim = range(qc)*c(1,1.1))
  oups <-which(rank(abs(qc - sd), ties = "random") > nrow(x) -3)
  text(qc[oups], sd[oups] - 1.5, names(oups))
  abline(a = 0, b = 1)
}
