#' @title compare_chi_square
#' @param df a data frame
#' @param group_1 first grouping variable
#' @param response treament that you are comparing (binary)
#'
#'
#' @export


compare_chi_square <- function(df, group_1, response){

  df<-df

  p <- broom::tidy(chisq.test(df[[response]], df[[group_1]]))$p.value

  fit <-chisq.test(df[[response]], df[[group_1]])

  out<-broom::augment(fit) %>%
    dplyr::filter(df..response.. == 1) %>%
    dplyr::mutate(diff_from_expected = .observed-.expected) %>%
    dplyr::rename(Expected = .expected,
                  Difference = diff_from_expected)

  effect_size <- tibble::data_frame(effect =  esc::esc_chisq(fit$statistic, totaln = nrow(df))[["es"]],
                                    low =  esc::esc_chisq(fit$statistic, totaln = nrow(df))[["ci.lo"]],
                                    high =  esc::esc_chisq(fit$statistic, totaln = nrow(df))[["ci.hi"]],
                                    error = esc::esc_chisq(fit$statistic, totaln = nrow(df))[["se"]]) %>%
    dplyr::mutate(description = dplyr::case_when(
      effect > 2~"Huge",
      effect > 1.2~"Very Large",
      effect > 0.8~ "Large",
      effect>0.5~"Medium",
      effect>0.2~"Small",
      effect>0.1~"Very Small",
      TRUE~"negligible"
    )) %>%
    dplyr::mutate(formatted = paste0(round(effect, 3), "+/-", round(error,2)))


  if(p < 0.05){
    cat(paste0("There is evidence of a significant statistically difference between these groups at the  0.05 level and ",effect_size$description," (", effect_size$formatted,") effect size. The expected differences are shown in the table below.", "\n"))

    response_2 <- enquo(response)

    df %>%
      mutate(!!rlang::sym(response) :=ifelse(!!rlang::sym(response) ==1, 'Yes', 'No')) %>%
      group_by(!!rlang::sym(response), !!rlang::sym(group_1)) %>%
      summarise(n = n()) %>%
      spread(response, n, fill = 0) %>%
      mutate(`Total` = Yes + No) %>%
      rename(`Response` = Yes) %>%
      bind_cols( ., out %>% select(Expected, Difference)) %>%
      select(group_1, `Total`, `Response`, Expected, Difference) %>%
      kable(digits = 0, booktabs = TRUE) %>%
      print(.)
  } else{
    cat(paste0("There is not significant evidence of a significant difference between these groups.", "\n"))
    df %>%
      mutate(!!rlang::sym(response) :=ifelse(!!rlang::sym(response) ==1, 'Yes', 'No')) %>%
      group_by(!!rlang::sym(response), !!rlang::sym(group_1)) %>%
      summarise(n = n()) %>%
      spread(response, n, fill = 0) %>%
      mutate(`Total` = Yes + No) %>%
      rename(`Response` = Yes) %>%
      bind_cols( ., out %>% select(Expected, Difference)) %>%
      select(group_1, `Total`, `Response`, Expected, Difference) %>%
      kable(digits = 0, booktabs = TRUE) %>%
      print(.)
  }
}
