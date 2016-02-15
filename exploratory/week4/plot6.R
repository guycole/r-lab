#
# plot6.R
#
library('ggplot2')
#
# given year, fips and type, return total emissions
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
fips_target1 = "24510"
fips_target2 = "06037"
#
years <- c(1999, 2002, 2005, 2008)
#
emissions1 = c()
emissions2 = c()
#
for (ndx in years) {
    emissions1 <- c(emissions1, yearEmissionsTotal(ndx, fips_target1, "ON-ROAD"))
    emissions2 <- c(emissions2, yearEmissionsTotal(ndx, fips_target2, "ON-ROAD"))
}
#
# barplot (by year)
#
par(mfrow = c(2, 1))
#
barplot(emissions1, main = "Baltimore City", names.arg = years)
barplot(emissions2, main = "Los Angeles County", names.arg = years)
dev.copy(png, file="plot6.png", width=480, height=480)
dev.off()
#