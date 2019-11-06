library(dplyr)

load_data <- function(dir="data"){
  files <- list.files(dir, pattern = "[0-9]+\\.csv", full.names = TRUE)
  x <- dplyr::bind_rows(lapply(files, read.csv, na.string = "-", stringsAsFactors = FALSE))
  x <- select(x, -session, -trial, -colour, -total)
  no_resp_trials <- x$response == "None"
  x[no_resp_trials, c("corr", "rt", "response")] <- NA
  x$null <- ifelse(x$null == 'yes', TRUE, FALSE)

  x$semester <- ifelse(as.Date(x$date, format = "%Y_%b_%d") < as.Date("2019-09-01"),
                       "SP19", "FA19"
                       )
  x <- select(x, subj, semester, cycle:points)
  x <- arrange(x, subj, cycle)
  return(x)
}
