# From Nathan's script
library(plotKML)
library(ggplot2)
library(maps)

# GPX files downloaded from Runkeeper
files <- dir(path = "./data", pattern = "\\.gpx")

# Consolidate routes in one drata frame
index <- c()
lat <- c()
long <- c()
for (i in 1:length(files)) {
  
  route <- readGPX(paste(c("./data/", files[i]), sep = "", collapse = ""))
  location <- route$tracks[[1]][[1]]
  
  index <- c(index, rep(i, dim(location)[1]))
  lat <- c(lat, location$lat)
  long <- c(long, location$lon)
}
routes <- data.frame(cbind(index, lat, long))

# Map the routes
ids <- unique(index)
plot(routes$long, routes$lat, type = "n", axes = FALSE, xlab = "", ylab = "", 
  main = "", asp = 1)
for (i in 1:length(ids)) {
  current_route <- subset(routes, index == ids[i])
  lines(current_route$long, current_route$lat, col = "#FF000020")
}

# Add the world map overlay
world <- map_data("world")
plot(world$long, world$lat, type = "n", axes = FALSE, xlab = "", ylab = "", 
  main = "", asp = 1)

world_groups <- unique(world$group)
for (i in 1:length(world_groups)) {
  current_route <- subset(world, group == world_groups[i])
  lines(current_route$long, current_route$lat, col = "#00000020")
}

route_groups <- unique(routes$index)
for (i in 1:length(route_groups)) {
  current_route <- subset(routes, index == route_groups[i])
  lines(current_route$long, current_route$lat, col = "#FF000020")
}

# Zoom into a particular area of routes
zoom <- function(routes, lat, long, radius) {
  lat_north <- lat + radius
  long_west <- long - radius
  lat_south <- lat - radius
  long_east <- long + radius
  routes.filtered <- routes[routes$lat < lat_north & routes$lat > lat_south & 
    routes$long > long_west & routes$long < long_east, ]
  
  # routes.filtered
  print(routes.filtered)
  plot(routes.filtered$long, routes.filtered$lat, type = "n", axes = FALSE, 
    xlab = "", ylab = "", main = "", asp = 1)
  route_groups <- unique(routes.filtered$index)
  for (i in 1:length(route_groups)) {
    current_route <- subset(routes.filtered, index == route_groups[i])
    lines(current_route$long, current_route$lat, col = "#FF000020")
  }
}

hoboken_lat <- 33.77
hoboken_long <- -84.40
radius <- 0.25

zoom(routes, hoboken_lat, hoboken_long, radius)
