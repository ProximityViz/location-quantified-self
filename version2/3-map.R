library(ggmap)

bike_routes <- subset(routes, mode == "Cycling")
car_routes <- subset(routes, mode == "Car")
transit_routes <- subset(routes, mode == "Transit")
walking_routes <- subset(routes, mode == "Walking")

# colors should probably all have the same brightness
red <- "#E10900" # or $f00000
orange <- "#f07300"
yellow <- "#F8B50C"
green <- "#0c7229"
blue <- "#0C4DF8" # or #6b99cb or #198dc4
purple <- "#3108A3"
black <- "#494846"
brown <- "#633301" # for hiking?

# TODO: rename this
map_image_data <- get_map(location = 
  c(
    lon = -84.39,
    lat = 33.80
  ),
  zoom = 13,
  # maptype = c("toner"),
  source = c("google"))
ggmap(map_image_data,
  extent = "device",
  darken = c(0.4, "white")) +
geom_path(
  aes(
    x = lon,
    y = lat
  ),
  data = car_routes,
  alpha = 0.5,
  colour = black,
  size = 1.2
) +
geom_path(
  aes(
    x = lon,
    y = lat
  ),
  data = transit_routes,
  alpha = 0.5,
  colour = blue,
  size = 1.2
) +
geom_path(
  aes(
    x = lon,
    y = lat
  ),
  data = bike_routes,
  alpha = 0.5,
  colour = orange,
  size = 1.2
) +
geom_path(
  aes(
    x = lon,
    y = lat
  ),
  data = walking_routes,
  alpha = 0.5,
  colour = green,
  size = 1.2
)
# TODO: hiking

# dev.copy(png, "maps/file-name.png")
# dev.off()
