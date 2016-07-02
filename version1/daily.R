all <- read.csv("atl.csv",
	header = TRUE)
day <- all[all$Date == "2013/07/27",]
# NEXT LINE IS ONLY FOR JUNE 1:
# day <- day[1598:2908,] #1598-2908 17:15:00
# day <- day[-1:-10, ] # drop first 10 obs to blur start point
# day <- day[-(length(day$Date)-9):-length(day$Date), ] # drop last 10 obs



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
# mapImageData <- get_map(location = c(lon = mean(day$Longitude), 
# 	lat = mean(day$Latitude)),
# 	zoom = 13, 
# 	color = "color", # or bw
# 	maptype = "toner",
# 	source = "stamen")
# # toner, stamen
mapImageData <- get_map(location = c(lon = -84.315, 
	lat = 33.76),
	zoom = 12, 
	color = "color", # or bw
	maptype = "toner",
	source = "stamen")
# toner, stamen


pathcolor <- "#F8971F" #D8B365 542788
trailhead <- "#542788"
color1 <- "#8C510A"

ggmap(mapImageData,
	extent = "panel", # "device" takes out axes, etc.
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







