#' @title make survey key
#' @description This is a function that can be used to extract information from a survey item created by the qualtrics API
#'
#'
#'
#' @param survey a list item that has been created from the qualtrics API
#'
#' @example
#'
#' #mysurvey <- getSurvey(surveyID = surveys$id[1], verbose = TRUE)
#' #survey_key <- make_survey_key(mysurvey)
#'
#' @export

make_survey_key <- function(survey){
  n <- ncol(survey)
  labels_list <- purrr::map(1:n, function(x) attr(survey[[x]], "label") )
  my_name <- c()
  question <-c()

  length_survey <- length(labels_list)

  for(i in 1:length_survey){
    my_name[i] <- if(length((labels_list[[i]][1]))==0){
      "None"}else{
        labels_list[[i]][1]
      }

    question[i] <- if(length(attributes(labels_list[[i]][1])$names)==0){
      "None"}else{
        paste0(attributes(labels_list[[i]][1])$names) %>% as.vector()
      }
    Encoding(question) <- "latin1"
    question <- enc2utf8(question)
    question <- gsub("â€¢","-",question)
    question <- gsub("â€™","'",question)
    question <- gsub("(*UCP)(*UTF)â€¢","--",question, perl= TRUE)
    question <- gsub("(*UCP)(*UTF)â€™","'",question, perl= TRUE)
  }

  survey_key <- data.frame(survey_id = my_name, question_details = question)
  return(survey_key)

}

