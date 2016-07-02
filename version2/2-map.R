library(ggmap)

# TODO: rename this
map_image_data <- get_map(location = 
  c(
    lon = -84.36,
    lat = 33.78
  ),
  zoom = 12,
  maptype = c("toner"),
  source = c("stamen"))
ggmap(map_image_data,
  extent = "device",
  darken = c(0.6, "white")) +
geom_path(
  aes(
    x = lon,
    y = lat
  ),
  data = routes,
  alpha = 0.5,
  colour = '#f07300',
  size = 1.2
)
