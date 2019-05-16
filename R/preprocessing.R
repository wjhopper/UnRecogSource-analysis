library(dplyr)

load_data <- function(dir="data"){
  files <- list.files(dir, pattern = "[0-9]+\\.csv", full.names = TRUE)
  x <- dplyr::bind_rows(lapply(files, read.csv, na.string = "-", stringsAsFactors = FALSE))
  x <- select(x, -session, -trial, -colour, -total)
  no_resp_trials <- x$response == "None"
  x[no_resp_trials, c("corr", "rt", "response")] <- NA
  x$null <- ifelse(x$null == 'yes', TRUE, FALSE)
  return(x)
}
