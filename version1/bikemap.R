# sudo gpsbabel -t -i gpx -f 1.gpx -o unicsv -F 1.csv
# sudo chmod 666 file.csv
# sudo gpsbabel -t -i garmin -f usb: -o unicsv -F temp.csv
# sudo gpsbabel -t -i garmin -f usb: -x track,start=2013061900 -o gtrnctr -F temp.tcx

new <- read.csv("atl.csv", 
	header = TRUE) # 2012/06/04 to 2013/08/22
new <- new[c("Latitude", "Longitude", "Seg", "Date")]

old <- read.csv("old.csv",
	header = TRUE) # 2011/05/26 to 2012/06/05
old <- old[c("Latitude", "Longitude", "Seg", "Date")]
# =if(G2<>G3,"",if(H3-H2>0.0694444,"",if(abs(B3-B2)>0.01,"",(if(abs(C3-C2)>0.01,"",1)))))

all <- rbind(new, old)
all$Latitude <- ifelse(is.na(all$Seg), NA, all$Latitude)
all$Longitude <- ifelse(is.na(all$Seg), NA, all$Longitude)


maxyear <- "2014"
through2011 <- all[substring(all$Date,1,4) <= maxyear,]
through2012 <- all[substring(all$Date,1,4) <= maxyear,]
through2013 <- all[substring(all$Date,1,4) <= maxyear,]
through2014 <- all[substring(all$Date,1,4) <= maxyear,]

library(ggmap)
# # standard:
# 	mapImageData <- get_map(location = c(lon = -84.33, 
# 		lat = 33.81),
# 		zoom = 12,
# 		# size = c(500, 500),
# 		maptype = c("toner"), #toner, watercolor
# 		source = c("stamen"))
# 	ggmap(mapImageData,
# 		extent = "device",
# 		darken = c(0.6, "white")) + # takes out axis, etc.
# 		geom_path(aes(x = Longitude,
# 			y = Latitude),
# 		data = all,
# 		colour = "black", #F8971F F4640D
# 		size = 1.2,
# 		pch = 20) +
# 		geom_path(aes(x = Longitude,
# 			y = Latitude),
# 		data = all,
# 		colour = "#F8971F", #F8971F F4640D
# 		size = 0.8,
# 		pch = 20)
# 	dev.copy(png, "Maps/bikemap.png")
# 	dev.off()

# # extra wide:
# 	mapImageData <- get_map(location = c(lon = -84.50, 
# 		lat = 33.83),
# 		zoom = 10,
# 		# size = c(500, 500),
# 		maptype = c("toner"), #toner, watercolor
# 		source = c("stamen"))
# 	ggmap(mapImageData,
# 		extent = "device",
# 		darken = c(0.6, "white")) + # takes out axis, etc.
# 		geom_path(aes(x = Longitude,
# 			y = Latitude),
# 		data = all,
# 		colour = "black", #F8971F F4640D
# 		size = 1.2,
# 		pch = 20) +
# 		geom_path(aes(x = Longitude,
# 			y = Latitude),
# 		data = all,
# 		colour = "#F8971F", #F8971F F4640D
# 		size = 0.8,
# 		pch = 20)
# 	dev.copy(png, "Maps/extrawide.png")
# 	dev.off()

# # downtown:
# 	mapImageData <- get_map(location = c(lon = -84.36, 
# 		lat = 33.76),
# 		zoom = 13,
# 		# size = c(500, 500),
# 		maptype = c("toner"), #toner, watercolor
# 		source = c("stamen"))
# 	ggmap(mapImageData,
# 		extent = "device",
# 		darken = c(0.6, "white")) + # takes out axis, etc.
# 		geom_path(aes(x = Longitude,
# 			y = Latitude),
# 		data = all,
# 		colour = "black", #F8971F F4640D
# 		size = 1.2,
# 		pch = 20) +
# 		geom_path(aes(x = Longitude,
# 			y = Latitude),
# 		data = all,
# 		colour = "#F8971F", #F8971F F4640D
# 		size = 0.8,
# 		pch = 20)
# 	dev.copy(png, "Maps/downtown.png")
# 	dev.off()

# downtownwide:
	mapImageData <- get_map(location = c(lon = -84.36, 
		lat = 33.78),
		zoom = 12,
		# size = c(500, 500),
		maptype = c("toner"), #toner, watercolor
		source = c("stamen"))
	ggmap(mapImageData,
		extent = "device",
		darken = c(0.6, "white")) + # takes out axis, etc.
		# geom_path(aes(x = Longitude,
		# 	y = Latitude),
		# data = all,
		# colour = "black", #F8971F F4640D
		# size = 1.2,
		# pch = 20) +
		geom_path(aes(x = Longitude,
			y = Latitude),
		data = through2014,
		alpha = 0.5,
		colour = "#f07300", #F8971F F4640D
		size = 1.2,
		pch = 20) +
		annotate("text",
			x = -84.274,
			y = 33.695,
			label = paste("2011 to", maxyear),
			size = 6,
			color = "#f07300") +
		annotate("text",
			x = -84.274,
			y = 33.695,
			label = paste("2011 to", maxyear),
			size = 6,
			color = "#000000")
	# dev.copy(png, "Maps/downtownwide-heat.png")
	# dev.off()

# # brookhaven:
# 	mapImageData <- get_map(location = c(lon = -84.35, 
# 		lat = 33.88),
# 		zoom = 13,
# 		# size = c(500, 500),
# 		maptype = c("toner"), #toner, watercolor
# 		source = c("stamen"))
# 	ggmap(mapImageData,
# 		extent = "device",
# 		darken = c(0.6, "white")) + # takes out axis, etc.
# 		geom_path(aes(x = Longitude,
# 			y = Latitude),
# 		data = all,
# 		colour = "black", #F8971F F4640D
# 		size = 1.2,
# 		pch = 20) +
# 		geom_path(aes(x = Longitude,
# 			y = Latitude),
# 		data = all,
# 		colour = "#F8971F", #F8971F F4640D
# 		size = 0.8,
# 		pch = 20)
# 	dev.copy(png, "Maps/brookhaven.png")
# 	dev.off()

# # northside:
# 	mapImageData <- get_map(location = c(lon = -84.29,
# 		lat = 33.92),
# 			zoom = 12,
# 			maptype = c("toner"),
# 			source = c("stamen"))
# 	ggmap(mapImageData,
# 		extent = "device",
# 		darken = c(0.6, "white")) + # takes out axis, etc.
# 		geom_path(aes(x = Longitude,
# 			y = Latitude),
# 		data = all,
# 		colour = "black", #F8971F F4640D
# 		size = 1.2,
# 		pch = 20) +
# 		geom_path(aes(x = Longitude,
# 			y = Latitude),
# 		data = all,
# 		colour = "#F8971F", #F8971F F4640D
# 		size = 0.8,
# 		pch = 20)
# 	dev.copy(png, "Maps/northside.png")
# 	dev.off()

# # downtownzoom:
# 	mapImageData <- get_map(location = c(lon = -84.4, 
# 		lat = 33.76),
# 		zoom = 14,
# 		# size = c(500, 500),
# 		maptype = c("toner"), #toner, watercolor
# 		source = c("stamen"))
# 	ggmap(mapImageData,
# 		extent = "device",
# 		darken = c(0.6, "white")) + # takes out axis, etc.
# 		geom_path(aes(x = Longitude,
# 			y = Latitude),
# 		data = all,
# 		colour = "black", #F8971F F4640D
# 		size = 1.2,
# 		pch = 20) +
# 		geom_path(aes(x = Longitude,
# 			y = Latitude),
# 		data = all,
# 		colour = "#F8971F", #F8971F F4640D
# 		size = 0.8,
# 		pch = 20)


all$Date <- as.Date(all$Date, format = "%Y/%m/%d")
newTracks <- all[which(all$Date >= "2013-10-25"),]
oldTracks <- all[which(all$Date < "2013-10-25"),]
naTracks <- all[which(is.na(all$Date) == TRUE),]


# # downtown compare:
# 	mapImageData <- get_map(location = c(lon = -84.36, 
# 		lat = 33.76),
# 		zoom = 13,
# 		# size = c(500, 500),
# 		maptype = c("toner"), #toner, watercolor
# 		source = c("stamen"))
# 	ggmap(mapImageData,
# 		extent = "device",
# 		darken = c(0.6, "white")) + # takes out axis, etc.
# 		geom_path(aes(x = Longitude,
# 			y = Latitude),
# 		data = all,
# 		colour = "black", #F8971F F4640D
# 		size = 1.2,
# 		pch = 20) +
# 		geom_path(aes(x = Longitude,
# 			y = Latitude),
# 		data = newTracks,
# 		colour = "#BD0026", #F8971F F4640D
# 		size = 0.8,
# 		pch = 20) +
# 		geom_path(aes(x = Longitude,
# 			y = Latitude),
# 		data = naTracks,
# 		colour = "#FEB24C", #F8971F F4640D
# 		size = 0.8,
# 		pch = 20) +
# 		geom_path(aes(x = Longitude,
# 			y = Latitude),
# 		data = oldTracks,
# 		colour = "#FEB24C", #F8971F F4640D
# 		size = 0.8,
# 		pch = 20)
# 	dev.copy(png, "Maps/compare.png")
# 	dev.off()





# # allmetro.png:
# mapImageData <- get_googlemap(center = c(lon = -84.27, lat = 33.83),
# 	zoom = 11,
# 	maptype = c("terrain"))

# # allmyhood.png:
# mapImageData <- get_googlemap(center = c(lon = -84.32, lat = 33.89),
# 	zoom = 13,
# 	maptype = c("terrain"))

# # alldowntown.png:
# mapImageData <- get_googlemap(center = c(lon = -84.34, lat = 33.77),
# 	zoom = 12,
# 	size = c(520, 520),
# 	maptype = c("terrain"))