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

plot(timestamp, filter1$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering") 
lines(timestamp, filter1$Sub_metering_2, col="red") 
lines(timestamp, filter1$Sub_metering_3, col="blue") 
legend("topright", col=c("black","red","blue"), c("Sub_metering_1 ","Sub_metering_2 ", "Sub_metering_3 "),lty=c(1,1), lwd=c(1,1))

dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()
