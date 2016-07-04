library(plotKML)

# GPX files downloaded from Runkeeper
files <- dir(path = "./data", pattern = "\\.gpx")
# for use in testing:
# files <- c("2016-06-27-2105.gpx")

accept_user_input <- function(question, existing_data, array = FALSE) {

  text <- ifelse(
    is.na(existing_data) || existing_data == "",
    ifelse(
      array,
      paste0("Enter the ", question, " for this track, separated by commas:"),
      paste0("Enter the ", question, " for this track:")
    ),
    paste0("If the following ", question, " data is correct, please press 'Enter', otherwise input the\ncorrect data\n", existing_data)
  )


  cat("---", text, sep="\n")
  user_input <- readLines(file("stdin"), 1)

  # if user_input is blank, return existing_data
  output <- ifelse(
    nchar(user_input) == 0, 
    existing_data, 
    user_input
  )
  # TODO: should they be able to remove the data that's there without inputting new data? this setup prevents that
  return (output)
}

add_metadata_to_file <- function(file_name, route) {
  # this function only works for Runkeeper data
  route_string <- names(route)
  metadata_items <- strsplit(route_string, " ")[[1]]
  local_start_datetime <- 0

  # allow user to check inputted metadata
  # allow user to add details and tags (e.g. uber, marta, #12)

  # LOCAL START DATETIME
  datetime_string <- paste(
    c(
      metadata_items[2], 
      " ", 
      metadata_items[3], 
      metadata_items[4]
    ), 
    sep = "", 
    collapse = ""
  )
  local_start_datetime <- strptime(
    datetime_string,
    format="%m/%d/%y %I:%M%p"
  ) # TODO: remove time zone or let them verify it

  cat("---------------------", sep="\n")
  cat("For the file named ", files[i], ", beginning at\n", format(local_start_datetime, "%I:%M %p"), " on ", format(local_start_datetime, "%A, %Y-%m-%d"), ",\nplease validate the following data:\n", sep = "")

  # MODE
  mode <- accept_user_input("mode", metadata_items[1])

  # UTC start & end times
  first_time <- route[[1]][1,]$time
  utc_start_datetime <- strptime(first_time, "%FT%T")

  points <- length(route[[1]]$time)
  last_time <- route[[1]][points,]$time
  utc_end_datetime <- strptime(last_time, "%FT%T")

  # TAGS
  tags <- accept_user_input("tags", "", TRUE)

  # INFO
  info <- accept_user_input("general information", "", FALSE)

  # TODO: add distance and runtime
  route_metadata <- c()
  route_metadata <- data.frame(
    file_name,
    mode, 
    local_start_datetime, 
    utc_start_datetime, 
    utc_end_datetime, 
    tags, 
    info
  )
  write.table(
    route_metadata,
    file = "./data/metadata.csv",
    append = TRUE,
    quote = TRUE,
    sep = ",",
    row.names = FALSE,
    col.names = FALSE
  )
}

for (i in 1:length(files)) {

  file_location <- paste(c("./data/", files[i]), sep = "", collapse = "")
  route <- readGPX(file_location)

  metadata <- read.csv(
    "./data/metadata.csv",
    header = TRUE,
    sep = ",",
    quote = "\""
  )

  # check if file is already in metadata file (by filename). if it is, don't add_metadata_to_file()
  if (length(metadata$file_path) == 0 | length(which(metadata$file_path == file_location)) == 0) {
    add_metadata_to_file(file_location, route$tracks[[1]])
  }

}
