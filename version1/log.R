library(ggplot2)
library(scales)
log <- read.csv("log.csv",
	header = TRUE)
log$Date <- as.Date(log$Date,
	"%Y-%m-%d")

colorset <- "#810404"

# by day:
ggplot(data = log,
	aes(Date, Miles)) +
	geom_bar(stat = "identity",
		fill = colorset)
dev.copy(png, "log-daily.png")
dev.off()

log$Week <- as.Date(cut(log$Date,
	breaks = "week"))

# by week:
ggplot(data = log,
	aes(Week, Miles)) + 
	stat_summary(fun.y = sum, 
		geom = "bar",
		fill = colorset) +
	scale_x_date(
		labels = date_format("%Y-%m-%d"), 
		breaks = "1 week")
dev.copy(png, "log-weekly.png")
dev.off()

log$Month <- as.Date(cut(log$Date,
	breaks = "month"))

# by month:
ggplot(data = log,
	aes(Month, Miles)) + 
	stat_summary(fun.y = sum, 
		geom = "bar",
		fill = colorset) +
	scale_x_date(
		labels = date_format("%Y-%m"), 
		breaks = "1 month")
dev.copy(png, "log-monthly.png")
dev.off()

log$Year <- as.Date(cut(log$Date,
	breaks = "year"))

# by year:
ggplot(data = log,
	aes(Year, Miles)) + 
	stat_summary(fun.y = sum, 
		geom = "bar",
		fill = colorset) +
	scale_x_date(
		labels = date_format("%Y"), 
		breaks = "1 year")
dev.copy(png, "log-yearly.png")
dev.off()