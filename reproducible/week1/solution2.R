#
# plot covered charges, total payments by medical condition and state.
#
rawData <- read.csv("payments.csv", header=TRUE)
#
#states <- unique(rawData$Provider.State)
#conditions <- unique(rawData$DRG.Definition)
#
library('ggplot2')
#
plot2 <- ggplot(rawData, aes(x=rawData$Average.Covered.Charges, y=rawData$Average.Total.Payments, shape=rawData$Provider.State, color=rawData$Provider.State)) + facet_wrap(~DRG.Definition, ncol=1) + geom_point() + labs(title="Charges vs Payments by Conditions and States", x="Covered Charges", y="Total Payments") + theme(legend.title=element_blank(), legend.position="top")
#
ggsave(file="plot2.png", plot=plot2)
#
