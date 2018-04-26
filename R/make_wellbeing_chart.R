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
  }else if (likert_scale == "agreementNA" ){
    my_levels <- c("Strongly agree", "Agree", "Slightly agree",
                 "Slightly disagree", "Disagree", "Slightly disagree",
                 "Don't know/ NA")
  }else if (likert_scale == "class" ){
    my_levels <- c("FY/ freshman", "Sophomore", "Junior", "Senior")
  }else if (likert_scale == "frequency" ){
    my_levels <-c("Not at all", "Several days", "Half the days", "Over half the days",
               "Nearly every day")
  }else if (likert_scale == "gender" ){
    my_levels <-c("Male", "Female", "Other")
  }else if (likert_scale == "gpa" ){
    my_levels <-c("A+", "A or A-", "B+", "B", "B-", "C+", "C", "C-", "D or lower")
  }else if (likert_scale == "housing" ){
    my_levels <-c("First-year student", "Culture-specific", "Special academic",
             "Other special interest", "Residence hall", "Apartment", "Fraternity or sorority",
             "Other residential", "Apartment house", "Other")
  }else if (likert_scale == "likely" ){
    my_levels <-c("Very likely", "Moderately likely", "Slightly likely", "Slightly unlikely",
            "Moderately unlikely", "Very unlikely")
  }else if (likert_scale == "loans" ){
    my_levels <- c("Less than $10,000","$10,000 - $19,000", "$20,000 - $29,999", "$30,000 - $39,999", "$40,000 or more")
  }else if (likert_scale == "military" ){
    my_levels <- c("None", "ROTC, cadet, midshipman at service academy", "Reserve or National Guard",
              "Active Duty", "Discharched vet")
  }else if (likert_scale == "often" ){
    my_levels <- c("Very often", "Often", "Sometimes", "Seldom", "Never")
  }else if (likert_scale == "purpose" ){
    my_levels <- c("Have goals", "Defining goals", "No goals")
  }else if (likert_scale == "ra" ){
    my_levels <- c("Yes", "No", "No, never")
  }else if (likert_scale == "race" ){
    my_levels <- c("Hispanic/ Latino", "American Indian/ Alaska Native", "Asian", "Black or AA",
          "Native Hawaiian or PI", "White", "2 or more")
  }else if (likert_scale == "romantic" ){
    my_levels <- c("In relationship", "Would be in relationship", "Casual relationships only", "Not interested")
  }else if (likert_scale == "sexor" ){
    my_levels <- c("Asexual", "Bisexual", "Gay", "Heterosexual", "Lesbian", "Other")
  }else if (likert_scale == "spirituality" ){
    my_levels <-  c("Buddhist", "Catholic", "Protestant", "Christian Other",
                  "Hindu", "Jewish", "Muslim", "Other", "Multiple", "None", "Unknown")
  }else if (likert_scale == "substance" ){
    my_levels <- c("0", "1", "2", "3-5", "6-9", "10+")
  }else if (likert_scale == "work" ){
    my_levels <- c("0", "1-7", "8-12", "13 or more")
  }else if (likert_scale == "yn" ){
    my_levels <- c("Yes", "No")
  }else if (likert_scale == "ynd" ){
    my_levels <- c("Yes", "No", "Don't know")
  }else if (likert_scale == "ynns" ){
    my_levels <- c("Yes", "No", "Not sure")
  }else if (likert_scale == "ynplan" ){
    my_levels <- c("Yes", "No", "No, but plan to")
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
    scale_x_discrete(labels = function(x) str_wrap(x, width = 10))

}

