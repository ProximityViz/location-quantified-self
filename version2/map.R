# inputs: date range, modes, heatmap (true/false), bounding box (optional)
 
# install.packages("plotKML")
library(plotKML)
library(ggplot2)
library(ggmap)
library(maps)

files <- dir(path="./data", pattern = "\\.gpx")

index <- c()
lat <- c()
long <- c()
for (i in 1:length(files)) {
    print(files[i])
    route <- readGPX(paste(c('./data/', files[i]), sep='', collapse=''))
    location <- route$tracks[[1]][[1]]
    
    index <- c(index, rep(i, dim(location)[1]))
    lat <- c(lat, location$lat)
    long <- c(long, location$lon)
}

routes <- data.frame(cbind(index, lat, long))

ids <- unique(index)
# plot(routes$long, routes$lat, type="n", axes=FALSE, xlab="", ylab="", main="", asp=1)
# for (i in 1:length(ids)) {
#     currRoute <- subset(routes, index==ids[i])
#     lines(currRoute$long, currRoute$lat, col="#FF000020")
# }

# world <- map_data('world')
# plot(world$long, world$lat, type="n", axes=FALSE, xlab="", ylab="", main="", asp=1)

map <- ggmap(get_googlemap(center=as.numeric(geocode("Atlanta, GA")), scale=2, zoom=10), extent="normal")

map + geom_point(aes(x=lon, y=lat), data=routes, col="orange", alpha=0.4)



