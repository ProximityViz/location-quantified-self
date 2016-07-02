# sudo gpsbabel -t -i garmin -f usb: -o unicsv -F file.csv
# sudo chmod 666 file.csv

gps <- read.csv("silverlake.csv", 
	header = TRUE)

max(gps$Latitude)-min(gps$Latitude)
max(gps$Longitude)-min(gps$Longitude)


# library(ggmap)
# mapImageData <- get_map(location = c(lon = mean(gps$Longitude), 
# 	lat = mean(gps$Latitude)),
# 	zoom = 14, 
# 	color = "color", # or bw
# 	maptype = "roadmap",
# 	source = "osm") # or type:terrain; source:stamen


pathcolor <- "#F8971F" #D8B365 542788
color1 <- "#8C510A"

# ggmap(mapImageData,
# 	extent = "panel", # "device" takes out axes, etc.
# 	ylab = "Latitude",
# 	xlab = "Longitude",
# 	legend = "right") + 
# 	geom_path(aes(x = Longitude, # path outline
# 	y = Latitude),
# 	data = gps,
# 	colour = "black",
# 	size = 2) +
# 	geom_path(aes(x = Longitude, # path
# 	y = Latitude),
# 	data = gps,
# 	colour = pathcolor,
# 	size = 1.4)



