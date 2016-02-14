#
# plot6.R
#
# given year and SCC code, return total emissions
#
yearEmissionsTotal <- function(year2, fips2, scc2) {
    temp <- subset(NEI, year == year2 & fips == fips2 & SCC == scc2)
    sum(temp$Emissions, na.rm = TRUE)
}
#
# inspect "source classification code" file for motor vehicle sources
# return SCC codes
#
discoverVehicleCode <- function() {
    results = c()

    for (ndx1 in 1:nrow(SCC)) {
        temp1 <- SCC[ndx1, 3]
	if (grepl("Highway Veh", temp1)) {
            results <- c(results, as.numeric(as.character(SCC[ndx1, 1])))
        }
    }

    return(results)
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
SCC <- readRDS("Source_Classification_Code.rds")
#
target_codes <- discoverVehicleCode()
#
fips_target1 = 24510
fips_target2 = 06037
#
years <- c(1999, 2002, 2005, 2008)
#
names <- list(years, target_codes)
#
emissions1 = matrix(nrow=length(years), ncol=length(target_codes), dimnames=names)
emissions2 = matrix(nrow=length(years), ncol=length(target_codes), dimnames=names)
#
for (ndx1 in 1:length(years)) {
    for (ndx2 in 1:length(target_codes)) {
    	print(sprintf("%d %d//%d %f", ndx1, years[ndx1], ndx2, target_codes[ndx2]))
        emissions1[ndx1, ndx2] <- yearEmissionsTotal(years[ndx1], fips_target1, target_codes[ndx2])
        emissions2[ndx1, ndx2] <- yearEmissionsTotal(years[ndx1], fips_target2, target_codes[ndx2])
    }
}
#
# barplot (by year) for each point source
#
#par(mfrow = c(2, 2))
#
#for (ndx1 in 1:length(source_type)) {
#    barplot(emissions[,ndx1], main = source_type[ndx1])
#}
#
#dev.copy(png, file="plot6.png", width=480, height=480)
#dev.off()
#