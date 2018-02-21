#' @title Binary Predictive Power over Time
#' @description This function looks at the predictive power of predictors over time
#'     using binomial logistic regression (logit link).
#' @param df the data frame to use
#' @param group the group by variable
#' @param  predictor the predictor you wish to use
#' @param outcome the binary outcome you wish to test against
#' @export

visual_predictive_power_time <- function(df, group, predictor, outcome){
  group. <- rlang::enquo(group)
  predictor. <- rlang::enquo(predictor)
  outcome. <- rlang::enquo(outcome)

  f <- paste(outcome, "~", predictor)
  my_title <- paste0("Impact of Predictor Over Time of ", predictor, " on ", outcome)
  print(f)
  p<-df %>%
    select(!!group., !!predictor., !!outcome.) %>%
    group_by(!!group.) %>%
    nest() %>%
    mutate(model = purrr::map(data, ~broom::tidy(glm(as.formula(f),
                                                     data = ., family = "binomial"))[2,])) %>%
    unnest(model) %>%
    arrange(!!group.) %>%
    ggplot(aes(year, estimate))+
    geom_errorbar(aes(ymin=estimate-std.error, ymax=estimate+std.error), width=.1)+
    geom_point(size=5)+
    geom_hline(yintercept = 0, color = "red", alpha = 0.5)+
    theme_fivethirtyeight()+
    labs(
      title = my_title,
      subtitle = "Error Bar Represent 1 SE"
    )
  return(p)
}

#' @example don't run{
#' visual_predictive_power_time(df =df_test, group = year,
#' predictor = "term_gpa_2", outcome = "left_1st_yr")
#' }
