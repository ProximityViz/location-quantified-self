day <- read.csv("20130622.csv",
	header = TRUE)

day$Latitude <- ifelse(is.na(day$Seg), NA, day$Latitude)
day$Longitude <- ifelse(is.na(day$Seg), NA, day$Longitude)



# source		maptype
# ------		-------
# google		terrain
# google		satellite
# google		roadmap
# google		hybrid
# stamen		terrain
# stamen		watercolor
# stamen		toner
# cloudmade		[positive integer]




library(ggmap)
mapImageData <- get_map(location = c(lon = -84.28, 
	lat = 34.0),
	zoom = 11, 
	color = "color", # or bw
	maptype = "terrain",
	source = "google")
# toner, stamen


pathcolor <- "#F8971F" #D8B365 542788
trailhead <- "#542788"
color1 <- "#8C510A"

ggmap(mapImageData,
	extent = "device", # "device" takes out axes, etc.
	ylab = "Latitude",
	xlab = "Longitude",
	legend = "right") + 
	theme(
		axis.title.x = element_text(colour = "white",
			size = 0),
		axis.title.y = element_text(colour = "white",
			size = 0),
		axis.text.x = element_text(size = 7),
		axis.text.y = element_text(size = 7)) +
	geom_path(aes(x = Longitude, # path outline
	y = Latitude),
	data = day,
	colour = "black",
	size = 2) +
	geom_path(aes(x = Longitude, # path
	y = Latitude),
	data = day,
	colour = pathcolor,
	size = 1.4)







