filter1 <- function(infile, outfile, targets) {
	outframe <- data.frame()

	rawdat1 <- read.table(infile, header=TRUE, sep=";")

	for (rowndx in 1:nrow(rawdat1)) {
		datetemp <- as.Date(rawdat1[rowndx,1], format = "%d/%m/%Y")

		for (targetndx in 1:length(targets)) {
			if (datetemp == targets[targetndx]) {
				outframe <- rbind(outframe, rawdat1[rowndx,])
			}
		}
	}

	write.csv(file=outfile, outframe)
}

targets <- as.Date(c("2007-02-01", "2007-02-02"))
filtfile <- "filtered1.csv"

if (!file.exists(filtfile)) {
	filter1("household_power_consumption.txt", filtfile, targets)
}

filter1 <- read.csv(filtfile)

timestamp <- strptime(paste(filter1$Date, filter1$Time), "%d/%m/%Y %H:%M:%S")

globalactive <- as.numeric(as.character(filter1$Global_active_power)) 
globalreactive <- as.numeric(as.character(filter1$Global_reactive_power)) 
voltage <- as.numeric(as.character(filter1$Voltage)) 

plot(timestamp, globalactive, type="l", xlab="", ylab="Global Active Power (kilowatts)") 
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()
