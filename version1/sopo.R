# sudo gpsbabel -t -i garmin -f usb: -o unicsv -F file.csv
# sudo chmod 666 file.csv

gps <- read.csv("sopo.csv", 
	header = TRUE)

pathcolor <- "#F8971F" #D8B365 542788
color1 <- "#8C510A"

library(RColorBrewer)
library(classInt)
plotclr <- brewer.pal(9, "YlOrRd")

library(ggmap)
mapImageData <- get_map(location = c(lon = mean(gps$Longitude), 
	lat = mean(gps$Latitude)),
	zoom = 13, 
	color = "color", # or bw
	maptype = "toner",
	source = "stamen") # or type:terrain; source:stamen


pathcolor <- "#F8971F" #D8B365 542788
trailhead <- "#542788"
color1 <- "#8C510A"

ggmap(mapImageData,
	extent = "device", # "device" takes out axes, etc.
	ylab = "Latitude",
	xlab = "Longitude",
	legend = "right") + 
	geom_path(aes(x = Longitude, # path outline
	y = Latitude),
	data = gps,
	colour = "black",
	size = 2) +
	geom_path(aes(x = Longitude, # path
	y = Latitude),
	data = gps,
	colour = pathcolor,
	size = 1.4) # +
# labs(title = "Slapper & McGee Take on Sopo's Broken Hearts and Bicycle Parts \n Scavenger Hunt",
#   x = "Longitude",
#   y = "Latitude")