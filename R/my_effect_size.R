#' @title My Effect Size Calculation
#' @description A simple tool to calculate pairwise effect sizes
#'   It takes the dataframe that has already been gathered (using tidyr)
#'   and summarised into variables that include mu(mean), var(variance) and
#'   freq(count). It then applies Cohen's D equation to calculate effect size
#'   and output both the scaled effect and the descriptor.
#'
#'   It will apply this to data that is given in the "key", "value" format.
#' @param df with a column titled key, my, var and freq
#'
#' @export

my_es <- function(df){
  keys <- unique(df$key)

  out <- c()

  for( i in 1:length(keys)){
    new <- df %>%
      filter(key == keys[i])

    lx <- new$freq[[1]]
    ly <- new$freq[[2]]
    med <- abs(new$mu[[1]] - new$mu[[2]])
    csd <- lx * new$var[[1]] + ly * new$var[[2]]
    csd <- csd / (lx + ly)
    csd <- sqrt(csd)
    cd <- med / csd

    es <- cd
    es_sigma <- sqrt((ly + lx) / (lx + ly) + es^2/(2 * (lx + ly)))
    es_ci <- es_sigma * 1.96

    statz <- rbind(es, es_sigma, es_ci)

    out<- rbind(out, statz)
  }

  out <- out%>%
    as.data.frame() %>%
    mutate(effect_size = case_when(
      es >2~"Huge",
      es > 1.2~ "Very large",
      es > 0.8~"Large",
      es > 0.5~"Medium",
      es > 0.2~"Small",
      TRUE~"Very Small"
    )) %>%
    add_column(.,keys)

  (out)
}
