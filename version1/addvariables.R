# sudo gpsbabel -t -i gpx -f 1.gpx -o unicsv -F 1.csv
# sudo chmod 666 file.csv

filename <- "../../../../../Downloads/12.csv"

temp <- read.csv(filename, 
	header = TRUE)
temp$Depth <- NA
temp$Cadence <- NA
temp <- temp[c(1,2,3,4,7,8,5,6)]
temp$Seg <- 1
temp$Seg[1] <- NA

write.csv(temp, 
	filename,
	quote = FALSE,
	row.names = FALSE)