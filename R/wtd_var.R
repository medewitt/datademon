#'@title weighted variance from Hmisc
#'@param x the vector to average
#'@param weights the weights

#'@export
wtd_var <- function(x, weights = NULL, normwt = FALSE, na.rm = TRUE,
                    method = c("unbiased", "ML"))
{
  if (!length(weights)) {
    if (na.rm) x <- x[!is.na(x)]
    return(var(x))
  }

  if (na.rm) {
    s <- !is.na(x + weights)
    x <- x[s]
    weights <- weights[s]
  }

  method <- match.arg(method)
  if (method == "ML") {
    return(as.numeric(stats::cov.wt(cbind(x), w, method = "ML")$cov))
  } else {
    sw <- sum(weights)
    xbar <- sum(weights * x) / sw
    num <- sum(weights * ((x - xbar)^2))

    den <- sw - if (normwt) sum(weights^2) / sw else 1

    return(num / den)
  }
}
