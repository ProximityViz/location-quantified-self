library(plotKML)

# GPX files downloaded from Runkeeper
files <- dir(path = "./data", pattern = "\\.gpx")
# for use in testing:
# files <- c("2016-06-27-2105.gpx", "2016-06-28-1823.gpx", "224818.gpx")

# Consolidate routes in one data frame
index <- c()
lat <- c()
lon <- c()
mode <- c()
for (i in 1:length(files)) {

  file_location <- paste(c("./data/", files[i]), sep = "", collapse = "")
  route <- readGPX(file_location)
  location <- route$tracks[[1]][[1]]
  route_mode <- metadata[which(metadata$file_path == file_location),]$mode
  
  index <- c(index, rep(i, dim(location)[1]))
  lat <- c(lat, location$lat)
  lon <- c(lon, location$lon)
  mode_name <- levels(route_mode)[route_mode]
  mode <- c(mode, rep(mode_name, dim(location)[1]))

  # add a blank row
  # TODO: might be more efficient to add it to the top, so you don't need to calculate lengths. benchmark this
  lat[length(lat)] <- NA
  lon[length(lon)] <- NA

}
routes <- data.frame(cbind(index, lat, lon, mode))
routes$lat <- as.numeric(levels(routes$lat))[routes$lat]
routes$lon <- as.numeric(levels(routes$lon))[routes$lon]

# TODO: sort & split by mode

# TODO: split this file into 2: one for cleaning, one for concatenating the data wanted for a specific map (e.g. bike rides in the last month)
