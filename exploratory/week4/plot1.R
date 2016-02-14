#
# plot1.R
#
yearEmissionsTotal <- function(target) {
    temp <- subset(NEI, year == target)
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
    emissions <- c(emissions, yearEmissionsTotal(ndx))
}
#
barplot(emissions, main = "Annual Emissions", names.arg = years)
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()
#