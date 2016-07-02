library(plotKML)

# GPX files downloaded from Runkeeper
files <- dir(path = "./data", pattern = "\\.gpx")
# for use in testing:
# files <- c("2015-02-04-1937.gpx", "2015-03-02-1250.gpx")

# Consolidate routes in one drata frame
index <- c()
lat <- c()
lon <- c()
for (i in 1:length(files)) {
  # TODO: save the time & mode data
  # (route has the mode data)
  # (route[[1]][[1]] has the time and date data)
  # possibly save it into a separate metadata file (one row per route) instead of as columns in the routes data

  route <- readGPX(paste(c("./data/", files[i]), sep = "", collapse = ""))
  location <- route$tracks[[1]][[1]]
  
  index <- c(index, rep(i, dim(location)[1]))
  lat <- c(lat, location$lat)
  lon <- c(lon, location$lon)

  # add a blank row
  # TODO: might be more efficient to add it to the top, so you don't need to calculate lengths. benchmark this
  lat[length(lat)] <- NA
  lon[length(lon)] <- NA

}
routes <- data.frame(cbind(index, lat, lon))

# TODO: split this file into 2: one for cleaning, one for concatenating the data wanted for a specific map (e.g. bike rides in the last month)

