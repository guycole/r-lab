#
#
fileName = "activity.csv"
rawData <- read.csv(fileName, header=TRUE)
#
# discover missing value population
missingStep <- is.na(rawData$steps)
missingPopulation <- sum(missingStep)
print(sprintf("total quantity of NA step values %d", missingPopulation))
#
# Discover daily mean, median and total steps
library(dplyr)
rawDailyScore <- rawData %>% group_by(date) %>% summarise(totalSteps = sum(steps), meanSteps = mean(steps), medianSteps = median(steps))
#
png("hist1.png", width=4, height=4, units="in", res=300)
hist(rawDailyScore$totalSteps, main="Histogram of Total Daily Steps", xlab="Total Daily Steps")
dev.off()
#
# Discover interval mean
rawIntervalMean <- rawData %>% group_by(interval) %>% summarise_each(funs(mean(., na.rm=TRUE)))
#
# Create cooked data set
#   Replace each missing steps value w/average interval value
#   Flag weekday vs weekend
date <- as.Date(rawData$date)
interval <- rawData$interval
steps <- vector(mode="integer", length=length(rawData$steps))
dayFlag <- vector(mode="logical", length=length(date))

for (ii in 1:length(rawData$steps)) {
  if (is.na(rawData$steps[ii])) {
    temp <- filter(rawIntervalMean, interval == rawData$interval[ii])
    steps[ii] = temp$steps
  } else {
    steps[ii] = rawData$steps[ii]
  }
}

weekDayCounter = 0
weekEndCounter = 0

library(pracma)
for (ii in 1:length(date)) {
  temp <- weekdays(date[ii])
  if (strcmp(temp, "Saturday") || strcmp(temp, "Sunday")) {
    dayFlag[ii] = TRUE
    weekEndCounter = weekEndCounter + 1
  } else {
    dayFlag[ii] = FALSE
    weekDayCounter = weekDayCounter + 1
  }
}

cookedData = data.frame(date, interval, steps, dayFlag)

cookedIntervalMean <- cookedData %>% group_by(interval) %>% summarise(meanSteps = mean(steps))
png("line1.png", width=4, height=4, units="in", res=300)
plot(cookedIntervalMean$meanSteps, type="l", main="Average Steps Time Series", xlab="Time", ylab="Steps")
dev.off()

cookedDailyScore <- cookedData %>% group_by(date) %>% summarise(totalSteps = sum(steps), meanSteps = mean(steps), medianSteps = median(steps))

#png("hist2.png", width=4, height=4, units="in", res=300)
hist(cookedDailyScore$totalSteps, main="Histogram of Total Daily Steps", xlab="Total Daily Steps")
#dev.off()

library(grid)
library(gridExtra)
#library(ggplot2)
weekEndData <- filter(cookedData, dayFlag == TRUE)
weekEndIntervalMean <- weekEndData %>% group_by(interval) %>% summarise(meanSteps = mean(steps))
p1 <- ggplot(weekEndIntervalMean, aes(x=meanSteps, y=interval)) + labs(title="weekend", x="interval", y="average steps") + geom_line()

weekDayData <- filter(cookedData, dayFlag == FALSE)
weekDayIntervalMean <- weekDayData %>% group_by(interval) %>% summarise(meanSteps = mean(steps))
p2 <- ggplot(weekDayIntervalMean, aes(x=meanSteps, y=interval)) + labs(title="weekday", x="interval", y="average steps") + geom_line()

p3 <- grid.arrange(p1, p2, nrow = 2, ncol = 1)

ggsave("compare.png", p3)
