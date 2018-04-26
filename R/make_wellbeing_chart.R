#' @title MAke Wellbeing Likert Chart
#' @param mygroup the question name you wish to group
#' @param likert_scale the Likert Scale to Use ("agreement", "frequency", "satisfaction")
#' @details The purpose of this function to faciliate making charts quickly
#' it utilizes the stock likert scales that are used in the wellbeing survey
#'
#' @export

make_wellbeing_charts <- function(data, mygroup, likert_scale) {
  if(is.na(likert_scale)){
    stop("Please specify the scale you with to use")
  }
  if(likert_scale == "agreement"){
    my_levels <- c("Strongly agree", "Agree",
                   "Slightly agree", "Slightly disagree",
                   "Disagree", "Strongly disagree")
  }else if (likert_scale == "frequency" ){
    my_levels <- c("Never", "Seldom", "Sometimes", "Often", "Very often")
  } else if(likert_scale == "satisfaction"){
    my_levels <- c("Very Dissatisfied", "Moderately Dissatisfied",
                   "Slightly Dissatisfied", "Slightly Satisfied",
                  " Moderately Satisfied", "Very Satisfied")
  }else{
    stop("Please enter a correct scale name.")
  }
  quo_var <- rlang::enquo(mygroup)
  a <- data %>%
    filter(question == !! quo_var, !is.na(perc_no_na)) %>%
    mutate(response_fact = factor(response,
                                  levels = my_levels))
  my_title <<- unique(data$formatted_title)

  ggplot(a,aes(response_fact, perc_no_na, fill = response_fact))+
    geom_col()+
    theme_wellbeing()+
    theme(panel.grid.major.x = element_blank(), panel.grid.minor.x = element_blank())+
    scale_fill_wellness()+
    ggtitle(paste0(my_title))+
    geom_text(aes(label = paste0(round(perc_no_na,1),"%")), nudge_y=3)+
    scale_x_discrete(labels = function(x) stringr::str_wrap(x, width = 10))

}

