pollutantmean <- function(directory, pollutant, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'pollutant' is a character vector of length 1 indicating
        ## the name of the pollutant for which we will calculate the
        ## mean; either "sulfate" or "nitrate".

        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used

        ## Return the mean of the pollutant across all monitors list
        ## in the 'id' vector (ignoring NA values)
        ## NOTE: Do not round the result!

	data_frame <- data.frame()

	file_list <- list.files(directory, full.names=TRUE)
	for (ndx in id) {
		data_frame <- rbind(data_frame, read.csv(file_list[ndx]))
	}

	if (pollutant == 'nitrate') {
		mean(data_frame[, 3], na.rm=TRUE)
	} else {
		mean(data_frame[, 2], na.rm=TRUE)
	}
}
