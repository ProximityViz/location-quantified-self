library(ggmap)

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
  data = routes,
  alpha = 0.5,
  colour = '#f07300',
  size = 1.2
)

# 	dev.copy(png, "maps/file-name.png")
# 	dev.off()
