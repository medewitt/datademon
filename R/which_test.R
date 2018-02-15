#' @title What Frequentist Test?
#' @description This is a function that tests for normality and then proposes
#' what tool to use for significance testing (Null Hypothesis Testing)
#' @param data your dataset to use
#' @param variable the variable in which you are interested
#' @export
#'
#'


which_test <- function(data, variable, alpha = 0.05){
  quo_var <- rlang::enquo(variable)
    results <- data %>%
      dplyr::select(!!quo_var) %>%
      unlist() %>%
      shapiro.test() %>%
      broom::tidy() %>%
      dplyr::mutate(judgement = ifelse(p.value >alpha, "Use a T-Test", "Use Non-Parametric")) %>%
      dplyr::select(judgement)

  return(results)
}

#' @example
#' df <- tibble::tibble(x = rnorm(100,0,1), y= rt(100,5,1), z = rbeta(100,2,.01))
#'
#' which_test(df, x)
#'
#' which_test(df, y)
#'
#' which_test(df, z)

