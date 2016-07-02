# sudo gpsbabel -t -i garmin -f usb: -o unicsv -F file.csv
# sudo chmod 666 file.csv

gps <- read.csv("nancy.csv", 
	header = TRUE)

max(gps$Latitude)-min(gps$Latitude)
max(gps$Longitude)-min(gps$Longitude)


library(ggmap)
mapImageData <- get_map(location = c(lon = mean(gps$Longitude), 
	lat = mean(gps$Latitude)),
	zoom = 14, 
	color = "color", # or bw
	maptype = "roadmap",
	source = "osm") # or type:terrain; source:stamen


pathcolor <- "#F8971F" #D8B365 542788
color1 <- "#8C510A"

library(RColorBrewer)
library(classInt)
plotclr <- brewer.pal(9, "YlOrRd")
class <- classIntervals(gps$HR, 9, style = "quantile")
colcode <- findColours(class, plotclr)

ggmap(mapImageData,
	extent = "panel", # "device" takes out axes, etc.
	legend = "topleft") + 
	geom_path(aes(x = Longitude, # path outline
	y = Latitude),
	data = gps,
	colour = "black",
	size = 2) +
	geom_point(aes(x = Longitude,
		y = Latitude),
	data = gps,
	colour = colcode,
	size = 1.4,
	show_guide = TRUE) +
	# geom_point(aes(colour = HR),
	# 	data = gps) +
	theme(legend.position = "right") +
	map.scale()

