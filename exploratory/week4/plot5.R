#
# plot5.R
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
fips_target = 24510
#
years <- c(1999, 2002, 2005, 2008)
emissions = c()
#
for (ndx in years) {
    emissions <- c(emissions, yearEmissionsTotal(ndx, fips_target, "ON-ROAD"))
}
#
# barplot (by year)
#
barplot(emissions, main = "Vehicle Emissions", names.arg = years)
dev.copy(png, file="plot5.png", width=480, height=480)
dev.off()
#