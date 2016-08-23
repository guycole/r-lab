#
#
#
rawData <- read.csv("payments.csv", header=TRUE)
#
filterData <- rawData[which(rawData$Provider.State == 'NY'),]
#
plotData <- data.frame(filterData$Average.Covered.Charges, filterData$Average.Total.Payments)
#
library('ggplot2')
plot1 <- ggplot(data=plotData, aes(x=filterData.Average.Covered.Charges, y=filterData.Average.Total.Payments)) + geom_point() + labs(title="bogus", x="x lab", y="y lab")
ggsave(file="plot1.png", plot=plot1, width=5, height=4)
#
