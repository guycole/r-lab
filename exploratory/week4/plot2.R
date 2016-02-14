#
# plot2.R
#
yearEmissionsTotal <- function(year2, fips2) {
    temp <- subset(NEI, year == year2 & fips == fips2)
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
years <- c(1999, 2002, 2005, 2008)
emissions = c()
#
for (ndx in years) {
    emissions <- c(emissions, yearEmissionsTotal(ndx, 24510))
}
#
barplot(emissions, main = "Baltimore City Emissions", names.arg = years)
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()
#