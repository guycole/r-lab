#
# plot3.R
#
library('ggplot2')
#
yearEmissionsTotal <- function(year2, fips2, type2) {
    temp <- subset(NEI, year == year2 & fips == fips2 & type == type2)
    sum(temp$Emissions, na.rm = TRUE)
}
#
nei_file <- "summarySCC_PM25.rds"
zip_file <- "exdata-data-NEI_data.zip"
#
if (!file.exists(nei_file)) {
    unzip(zip_file)
}
#
NEI <- readRDS("summarySCC_PM25.rds")
#
fips_target = 24510
#
source_type <- c("POINT", "NONPOINT", "ON-ROAD", "NON-ROAD")
years <- c(1999, 2002, 2005, 2008)
#
names <- list(years, source_type)
#
emissions = matrix(nrow=length(years), ncol=length(source_type), dimnames=names)
#
for (ndx1 in 1:length(years)) {
    for (ndx2 in 1:length(source_type)) {
    	emissions[ndx1, ndx2] <- yearEmissionsTotal(years[ndx1], fips_target, source_type[ndx2])
    }
}
#
# barplot (by year) for each point source
#
par(mfrow = c(2, 2))
#
for (ndx1 in 1:length(source_type)) {
    barplot(emissions[,ndx1], main = source_type[ndx1])
}
#
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()
#