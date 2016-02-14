#
# plot4.R
#
# given year and SCC code, return total emissions
#
yearEmissionsTotal <- function(year2, scc2) {
    temp <- subset(NEI, year == year2 & SCC == scc2)
    sum(temp$Emissions, na.rm = TRUE)
}
#
# inspect "source classification code" file for combustible coal sources
# return SCC codes 
# 
discoverCoalCode <- function() {
    results = c()
    
    for (ndx1 in 1:nrow(SCC)) {
        temp1 <- SCC[ndx1, 3]
	if (grepl("Comb", temp1) & grepl("Coal", temp1)) {
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
target_codes <- discoverCoalCode()
#
years <- c(1999, 2002, 2005, 2008)
#
names <- list(years, target_codes)
emissions = matrix(nrow=length(years), ncol=length(target_codes), dimnames=names)
#
for (ndx1 in 1:length(years)) {
    for (ndx2 in 1:length(target_codes)) {
        emissions[ndx1, ndx2] <- yearEmissionsTotal(years[ndx1], target_codes[ndx2])
    }
}
#
coal_total <- vector(mode = "numeric", length=length(years))
for (ndx1 in 1:length(years)) {
    coal_total[ndx1] = sum(emissions[ndx1,])
}
#
barplot(coal_total, main = "Coal Emissions", names.arg = years)
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
#