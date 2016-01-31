# assumes UCI HAR data set is available in the current directory
zip_file <- "getdata-projectfiles-UCI HAR Dataset.zip"

if (!file.exists("UCI HAR Dataset")) {
	unzip(zip_file)
}

#
# test data
test_x <- read.table("UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")

#
# training data
train_x <- read.table("UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("UCI HAR Dataset/train/y_train.txt")
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")

#
# other data 
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

#
# merge (step 1)
all_subject <- rbind(train_subject, test_subject)
all_x <- rbind(train_x, test_x)
all_y <- rbind(train_y, test_y)

#
# rename to features
colnames(all_x) <- c(as.character(features[,2]))

#
# extract mean and standard deviation columns (step 2)
sd_ndx <- grep("std()", colnames(all_x), fixed=TRUE)
mean_ndx <- grep("mean()", colnames(all_x), fixed=TRUE)
extracted <- all_x[,c(sd_ndx, mean_ndx)]

#
# descriptive activity names (step 3)
all_activity <- cbind(all_y, extracted)
colnames(all_activity)[1] <- "Activity"

#
# descriptive variable names (step 4)
for (ii in 1:length(all_activity[,1])) {
	all_activity[ii, 1] <- as.character(activity_labels[all_activity[ii, 1], 2])
}

#
# tidy data set w/averages (step 5)
all2 <- cbind(all_subject, all_activity)
colnames(all2)[1] <- "Subject"

tidy <- aggregate(all2[,3] ~ Subject+Activity, data=all2, FUN="mean")

for (ii in 4:ncol(all2)) {
	tidy[,ii] <- aggregate(all2[,ii] ~ Subject+Activity, data=all2, FUN="mean")[, 3]
}

colnames(tidy)[3:ncol(tidy)] <- colnames(extracted)

write.table(tidy, file="tidy.txt")

# the end, thanks for reading
